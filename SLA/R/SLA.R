#' @title Main function
#' @name SLA
#'
#' @description This function is the wrapper of the SLA package.
#' The preprocessing, processing and postprocessing modules are called during the execution of this wrapper.
#'
#' @param config_json_filename The json file containing all parameters.
#'
#' @return No value is returned. The parameters define the need of output plots, tables, etc.
#'
#' @import jsonlite devtools

SLA = function(config_json_filename = NULL){

  # Checking the configuration jason filename
  if (is.null(config_json_filename)){
    stop("Use config_json_filename argument!")
  }
  if(!file.exists(config_json_filename)){
    stop("Use a valid configuration json filename!")
  }

  # Reading the json config
  cfg = fromJSON(config_json_filename)

  # Setup folder
  dirs = setupFolder(cfg = cfg)

  # Preprocessing module
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
              file = paste0(cfg$folders$preprocessed, 'preprocessed_', cfg$pre_process$filename))

    # Saving the SLA per user object
    save(customersData, file = paste0(cfg$folders$preprocessed, 'customersData.RData'))

    # Saving the cfg used
    save(cfg, file = paste0(cfg$folders$preprocessed, 'cfg.RData'))

  } else {

    # Load all preprocessed data
    dataset = read.csv(file = paste0(cfg$folders$preprocessed, 'preprocessed_', cfg$pre_process$filename),
                       header = cfg$pre_process$exist_header)

    load(file = paste0(cfg$folders$preprocessed, 'customersData.RData'))

  } # else of if preprocessing flag

  # Processing module
  if (cfg$process$run_process){
    print('ok') # WIP
  }

  # Post processing module
  if (cfg$post_process$run_postprocess){
    if (cfg$post_process$plot_sla$run_module){
      plotSLAs(cfg, customersData)
    }
    #plotCalls(cfg, dataset)
  }
}
