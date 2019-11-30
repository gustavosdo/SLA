#' @title Converts ISODate to a "numerical" format
#' @name convertDateFromIBM
#'
#' @description The date/time of closure of tickets is in a odd format. This format disable any type of
#' statistical treatment.
#'
#' @param cfg A json with configuration data
#' @param dataset The data frame from the source csv
#'
#' @return dataset The same dataset but with the date/time column with the correct format.
#'
#' @import parallel foreach doParallel

convertDateFromIBM = function(dataset, cfg){

  # Only not null close date time entries
  colTime = cfg$pre_process$closeDate_col
  dataset = dataset[dataset[colTime] != 'null',]

  # Converting date time format
  charDateTime = as.character(dataset[,colTime])
  charDateTime = gsub(x = charDateTime, pattern = 'ISODate', replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "\"", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "\\(", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "\\)", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "T", replacement = ' ')

  # Slicing the strings of closeDateTime
  charDateTime = sapply(charDateTime, function(x){substr(x = x, start = 1, stop = 19)})
  names(charDateTime) = as.character(unlist(dataset[cfg$pre_process$callNumber_col]))

  # Ensure only entries from the correct time range are considered
  iniDate = cfg$pre_process$initial_date
  endDate = cfg$pre_process$end_date

  # Parallelism setup
  threads = cfg$pre_process$threads
  cl <- parallel::makeCluster(threads, type = 'SOCK', outfile = "")
  doParallel::registerDoParallel(cl)
  on.exit(stopCluster(cl))

  # Entries in the correct time range
  corTimeRange = foreach (iter_name = names(charDateTime)[1:length(charDateTime)]) %dopar% {
    #.packages = c('devtools')
    #load_all()
    corTimeRange = as.list(NA)
    iter_name = as.character(iter_name)
    names(corTimeRange) = iter_name
    if (charDateTime[[iter_name]] >= iniDate & charDateTime[[iter_name]] <= endDate){
      corTimeRange[[iter_name]] = charDateTime[[iter_name]]
    }
    return(corTimeRange)
  }

  # returns the harmonized date/time set to original dataset
  dataset[colTime] = unlist(corTimeRange)
  dataset[!is.na(dataset[colTime]),]
  return(dataset)
}
