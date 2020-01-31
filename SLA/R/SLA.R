#' @title Main function
#' @name SLA
#'
#' @description This function is the wrapper of the SLA package.
#' The preprocessing, processing and postprocessing modules are called during
#' the execution of this wrapper.
#'
#' @param config_json_filename The json file containing all parameters.
#'
#' @return No value is returned. The parameters define the need of output plots,
#' tables, etc.
#'
#' @import jsonlite devtools

SLA = function(config_json_filename = NULL){

  # Initial setup --------------------------------------------------------------
  # Checking the configuration json filename
  if (is.null(config_json_filename)){
    stop("Use config_json_filename argument!")
  }
  if(!file.exists(config_json_filename)){
    stop("Use a valid configuration json filename!")
  }

  # Reading the json config
  cfg = fromJSON(config_json_filename)

  # Define and create folders of pre, post and processed files
  setupFolder(cfg = cfg)

  # Preprocessing module -------------------------------------------------------
  if (cfg$pre_process$run_preprocess){

    # Read data
    dataset = readData(cfg)

    # Formatting data correctly if needed
    if (cfg$pre_process$format_date){
      dataset = convertDateFromIBM(dataset = dataset, cfg = cfg)
    }

    # Determine the Service Level Agreement as function of time
    customersData = calcSLA(dataset = dataset, cfg = cfg)

    # Saving the resultant preprocessed dataset
    write.csv(x = dataset,
              file = paste0(cfg$folders$preprocessed, 'preprocessed_',
                            cfg$pre_process$filename))

    # Saving the SLA per user object
    save(customersData, file = paste0(cfg$folders$preprocessed,
                                      'customersData.RData'))

    # Saving the cfg used
    save(cfg, file = paste0(cfg$folders$preprocessed, 'cfg.RData'))

  } else {

    # Load all preprocessed data -----------------------------------------------
    dataset = read.csv(file = paste0(cfg$folders$preprocessed, 'preprocessed_',
                                     cfg$pre_process$filename),
                       header = cfg$pre_process$exist_header)

    load(file = paste0(cfg$folders$preprocessed, 'customersData.RData'))

  } # else of if preprocessing flag

  # Processing module ----------------------------------------------------------
  if (cfg$process$run_process){

    print('Process modules')

    # Perform the predictions --------------------------------------------------
    solutions = predictions(cfg = cfg, customersData = customersData)

    # Save the values for each day and customer
    save(solutions, file = paste0(cfg$folders$processed, 'solutions.RData'))

    # Determine accuracy -------------------------------------------------------
    # customersData without the last two days
    cfgTest = cfg # Copy the cfg in order to change some parameters harmlessly
    endTime = substr(x = cfg$pre_process$end_date, start = 12, stop = 19)
    cfgTest$pre_process$end_date = paste(as.Date(cfg$pre_process$end_date) - 2,
                                          endTime)
    cfgTest$process$days_prediction = ac(as.Date(cfg$pre_process$end_date) - 1)
    customersDataTest = calcSLA(dataset = dataset, cfg = cfgTest)

    # Determine the solution for a shorter time range
    solutionsTest = predictions(cfg = cfgTest,customersData = customersDataTest)

    # Two accuracy tests
    accTests = accuracy(customersData = customersData,
                        solutionsTest = solutionsTest,
                        dayTest = cfgTest$process$days_prediction,
                        cfg = cfg)

    # Save the tests results for each day and customer
    save(accTests, file = paste0(cfg$folders$processed, 'accTests.RData'))

  } else {
    # Load the previously done predictions for each day and customer -----------
    load(file = paste0(cfg$folders$processed, 'solutions.RData'))

    # Load the tests results for each day and customer -------------------------
    load(file = paste0(cfg$folders$processed, 'accTests.RData'))
  }

  # Post processing module -----------------------------------------------------
  if (cfg$post_process$run_postprocess){
    if (cfg$post_process$plot_sla$run_module){
      plotSLAs(cfg, customersData)
    }
    if (cfg$post_process$plot_calls$run_module){
      plotCalls(cfg, customersData)
    }
    if (cfg$post_process$plot_closed_calls$run_module){
      plotClosedCalls(cfg, customersData)
    }
  }
}
