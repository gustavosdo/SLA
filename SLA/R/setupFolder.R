#' @title Set the directory names.
#' @name setupFolder
#'
#' @description Set the directory names from which to load all the data for the processing
#' @param config_json_filename A json with configuration data
#'

setupFolder = function(cfg){

  # Set the directory names from which to load all the data for the computation
  in_dir = cfg$folders$input_folder
  preprocessed = cfg$folders$preprocessed
  processed = cfg$folders$processed
  postprocessed = cfg$folders$postprocessed
  dirs = list(in_dir = in_dir, preprocessed = preprocessed, processed = processed, postprocessed = postprocessed)

  # Create all directories
  for (iter_dir in dirs){
    if (!dir.exists(iter_dir)) dir.create(iter_dir)
  }

  return(dirs)
}
