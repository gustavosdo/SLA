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
#' @import jsonlite

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
  dirs = setup_folder(cfg = cfg)

  # Check the need to run preprocessing and processing
  if (!cfg$post_process$only_postprocess){

    # Preprocessing module
    if (cfg$pre_process$run_preprocess){

      # Read data
      dataset = readData(cfg)

      # Formatting data correctly if needed
      if (cfg$pre_process$format_date){
        dataset = convertDateFromIBM(dataset = dataset, cfg = cfg)
      }

      # Determine the Service Level Agreement as function of time
      SLA_per_user = calcSLA(dataset = dataset, cfg = cfg)

      # Saving the resultant preprocessed dataset
      write.csv(x = dataset,
                file = paste0(cfg$folders$preprocessed, 'preprocessed_', cfg$pre_process$filename))

      # Saving the SLA per user object
      save(SLA_per_user, file = paste0(cfg$folders$preprocessed, 'SLA_per_user'))

    } else {

      dataset = read.csv(file = paste0(cfg$folders$preprocessed, 'preprocessed_', cfg$pre_process$filename),
                         header = cfg$pre_process$exist_header)

      load(file = paste0(cfg$folders$preprocessed, 'SLA_per_user'))

    } # else of if preprocessing flag

    # Processing module
    if (cfg$process$run_process){
      print('ok') # WIP
    }
  } # if not only_postprocess
}
