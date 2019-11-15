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

  # Preprocessing and processing modules
  if (!cfg$post_process$only_post_process){

    # Read data
    dataset = read.csv(file = cfg$input$filename,
                       header = cfg$input$exist_header,
                       sep = cfg$input$separator)

    # Formatting data correctly if needed
    if (cfg$input$format_date){
      dataset = formatDate(dataset, cfg)
    }
  }
}
