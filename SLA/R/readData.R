#' @title Read and subset the csv
#' @name readData
#'
#' @description In this function the csv data source is read
#'
#' @param config_json_filename The json file containing all parameters.
#'
#' @return A csv containing the needed data for the analysis

readData = function(cfg){

  # Read the csv as defined by json config file
  dataset = read.csv(file = paste0(cfg$folders$input_folder, cfg$pre_process$filename),
                     header = cfg$pre_process$exist_header,
                     sep = cfg$pre_process$separator)

  # Define the relevant columns for the analysis
  relevant_cols = c(cfg$pre_process$closed_ticket_col,
                    cfg$pre_process$closed_ontime_col,
                    cfg$pre_process$closeDate_col,
                    cfg$pre_process$slaStatus_col,
                    cfg$pre_process$customers_col,
                    cfg$pre_process$callNumber_col)

  # Subset the csv with  the relevant data columns and returns it
  dataset = dataset[, names(dataset) %in% c(relevant_cols)]
  return(dataset)
}
