#' @title Set the directory names.
#' @name setup_folder
#'
#' @description Set the directory names from which to load all the data for the processing
#' @param config_json_filename A json with configuration data
#'

setup_folder = function(cfg){

  cat("Creating directory \n")

  # set the directory names from which to load all the data for the optimisation
  in_dir = cfg$folders$input_folder
  preprocessed = cfg$folders$preprocessed
  processed = cfg$folders$processed
  postprocessed = cfg$folders$postprocessed
  dirs = list(in_dir = in_dir, preprocessed = preprocessed, processed = processed, postprocessed = postprocessed)

  for (iter_dir in dirs){
    if (!dir.exists(iter_dir)) dir.create(iter_dir)
  }

  return(dirs)
}
