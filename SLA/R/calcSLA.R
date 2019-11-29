#' @title Wrapper of SLA variable determination
#' @name calcSLA
#'
#' @description Service Level Agreement is the fraction of tickets closed in time
#' w.r.t the total of tickets in the month until the considered time
#'
#' @param cfg A json with configuration data
#' @param dataset The dataset with the needed modifications done by convertDate
#'
#' @return listSLA A list of lists. Each list contains the SLA for a different customer
#'
#' @import parallel foreach doParallel

calcSLA = function(dataset, cfg){

  # Parallelism setup
  threads = cfg$pre_process$threads
  cl <- parallel::makeCluster(threads, type = 'SOCK', outfile = "")
  doParallel::registerDoParallel(cl)
  on.exit(stopCluster(cl))

  # Customer codes
  customerCodes = as.character(unique(dataset[,cfg$pre_process$customers_col]))

  # Calculate SLA for each user using threads
  customerSLAs = foreach (iter_name = customerCodes[1:length(customerCodes)], .export = c('calcCustomerSLA', 'createSLAdf')) %dopar% {
    customerSLA = as.list(NA)
    names(customerSLA) = iter_name
    datasetCustomer = dataset[dataset[cfg$pre_process$customers_col] == as.numeric(iter_name),]
    customerSLA[[iter_name]] = calcCustomerSLA(datasetCustomer, cfg)
    return(customerSLA)
  }

  # Getting the vector of date/time of closure
  #colTime = cfg$pre_process$closeDate_col
  #closedDateTime = dataset[colTime]

  # Getting

  # # Checking years of interest
  # n_years = length(seq(from = as.Date(cfg$pre_process$initial_date), to = as.Date(cfg$pre_process$end_date), by = 'year'))
  # initial_year = as.numeric(substr(cfg$pre_process$initial_date, 1, 4))
  # years = sapply(0:(n_years-1), function(x){initial_year + x})
  # # Check how many months ...
  # n_months = length(seq(from = as.Date(cfg$pre_process$initial_date), to = as.Date(cfg$pre_process$end_date), by = 'month'))
  # initial_month = substr(cfg$pre_process$initial_date, 6, 7)
  # months = sapply(as.numeric(initial_month):n_months, function(x){month.name[x]})
  # # ... and how many days for each month are there
  # days = sapply(1:(n_months*n_years), function(x){0})
  # month_year = expand.grid(as.character(years), months) ;
  # colnames(month_year) = c('year', 'month')
  # for (iter_row in 1:nrow(month_year)){
  #   iter_month = paste0(month_year[iter_row,1], '-', month_year[iter_row,2])
  #   # Get the initial day for each month of each year [NOT WORKING!]
  #   iter_list = sapply(closedDateTime$closeDateTime,
  #                      function(x){if (substr(x, 1, 7) == iter_month) {
  #                                                                       substr(x, 9, 10) } else { NULL } })
  #   #min(as.character.Date(iter_list))
  # }

  # n = Month sum of number of tickets closed on time (onTimeSolution = S; callStatus = N0, N4 or CV) per day
  #n_jan = rep(0, 31)
  #n_feb = rep(0, 31)

  # N = Month sum of number of tickets closed per day (callStatus = N0, N4 or CV)

  # SLA = n/N

  # Vector of days

  # Data frame with dates and SLA's

  # Return the data frame to proceed to processing
}
