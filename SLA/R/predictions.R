#' @title Preview of number of calls and closed calls based on various algorithms
#' @name predictions
#'
#' @description This module receives the all calls and closed calls for a
#' given date range and returns the expected value of calls and closed calls
#' for another date range
#'
#' @param cfg A json with configuration data
#' @param dataset The dataset with all customers information
#'
#' @return solution A vector with the SLA preview
#'
#' @import parallel foreach doParallel fpp2 xts zoo dplyr scales

predictions = function(cfg, customersData){

  # Parallelism setup ----
  threads = cfg$pre_process$threads
  cl <- parallel::makeCluster(threads, type = 'SOCK', outfile = "")
  doParallel::registerDoParallel(cl)
  on.exit(stopCluster(cl))

  # Unpacking customersData ----
  customersData = unlist(customersData, recursive = F)

  # Customers to be included in the predictions ----
  customers = cfg$process$customers
  if (is.null(customers)){customers = names(customersData)}

  # Variables (targets) to be included in the prediction ----
  variables = c("closeds", "allTickets")

  # Parallel loop over customers ----
  foreach (customer = customers[1:length(customers)], .packages = c('devtools', 'xts'), .export = c("variables", "customersData")) %dopar% {
    load_all(quiet = T)
    # Loop over variables ----
    for (variable in variables){
      # Data frame of a specific variable and customer
      Calls_df = customersData[customer][[1]][variable][[1]]
      # Vector of number of calls per day
      calls = na.omit(as.numeric(unlist(sapply(colnames(Calls_df), function(x){Calls_df[x]}))))
      # All days between start and end of date range
      dates = seq(from = as.Date(cfg$pre_process$initial_date), to = as.Date(cfg$pre_process$end_date), by = "day")
      # Determine the week day for each date
      weekDays = sapply(dates, function(x){weekdays(x = x)})
      weekDays = translateWeekDays(weekDays = weekDays)

      # Declare as a time series ----
      # Bind dates and calls per day
      data = data.frame(weekdays = weekDays, dates = dates, calls = calls)
      # Removing na's
      data = na.omit(data)

      # Prediction ----
      # We use a prediction based on the weighted mean of precedent values
      delta_calls = unlist(lapply(1:length(data$calls), function(j){data$calls[j] - data$calls[j-1]})) # removing trend
      delta_calls = c(NA, delta_calls) # adding a NA for the first entry as it is not possible to define delta_calls[1]
      data = cbind(data, delta_calls) # binding delta calls to data frame
      data$delta_calls[which(substr(data$dates, 9, 10) == "01")] = NA # adding a NA to the first day of every month

      # Loop over all the days to be predicted

      # Name for each var
      #names(predictions) = bla

    } # var iteration

    # Name for each customer
    #names(predictions) = bla

  } # for each (customer)

  #return(predictions)
}
