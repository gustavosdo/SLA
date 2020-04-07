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
#' @import jsonlite devtools DBI dplyr dbplyr odbc
#'
#' @export

SLA = function(config_json_filename = "~/Dropbox/Git/SLA/SLA/R/config.R") {

  # Read configurations file
  source(config_json_filename)

  # Define and create folders of pre, post and processed files
  setupFolder(cfg = cfg)

  # SQL definitions ------------------------------------------------------------
  #createSQL(cfg = cfg)

  # Preprocessing module -------------------------------------------------------
  # test the requirement to run preprocessing module
  if (cfg$post_process$only_postprocess){
    message("Skipping preprocessing as it was not required by configurations")
  } else {
    message("Starting pre-processing module")
    input_data = preProcess(cfg)
  }

  # Processing module ----------------------------------------------------------
  if (cfg$process$run_process){

    print('Process modules')

    # Perform the predictions --------------------------------------------------
    solutions = predictions(cfg = cfg, customersData = customersData)

    # Save the values for each day and customer
    save(solutions, file = paste0(cfg$folders$processed, 'solutions.RData'))

    # Determine accuracy -------------------------------------------------------
    if(cfg$process$accuracy_test){

      # customersData without the last two days
      cfgTest = cfg # Copy the cfg in order to change some parameters harmlessly
      endTime = substr(x = cfg$pre_process$end_date, start = 12, stop = 19)
      cfgTest$pre_process$end_date = paste(as.Date(cfg$pre_process$end_date)-2,
                                           endTime)
      cfgTest$process$days_prediction = ac(as.Date(cfg$pre_process$end_date)-1)
      customersDataTest = calcSLA(dataset = dataset, cfg = cfgTest)

      # Determine the solution for a shorter time range
      solutionsTest = predictions(cfg = cfgTest,
                                  customersData = customersDataTest)

      # Two accuracy tests
      accTests = accuracy(customersData = customersData,
                          solutionsTest = solutionsTest,
                          dayTest = cfgTest$process$days_prediction,
                          cfg = cfg)

      # Save the tests results for each day and customer
      save(accTests, file = paste0(cfg$folders$processed, 'accTests.RData'))
    }

  } else {
    # Load the tickets for each day and customer -------------------------------
    load(file = paste0(cfg$folders$processed, 'ticketsPredictions.RData'))

    # Load the previously done predictions for each day and customer -----------
    load(file = paste0(cfg$folders$processed, 'solutions.RData'))

    if(cfg$process$accuracy_test){
      # Load the tests results for each day and customer -----------------------
      load(file = paste0(cfg$folders$processed, 'accTests.RData'))
    }
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
