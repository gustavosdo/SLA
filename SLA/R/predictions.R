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
      Calls = list()
      Date = list()
      Calls_df = customersData[customer][[1]][variable][[1]]
      # Loop over date ----
      for (iter_col in 1:ncol(Calls_df)){
        iter_col_name = colnames(Calls_df)[iter_col]
        for (iter_row in 1:nrow(Calls_df)){
          iter_row_name = ifelse( nchar(ac(iter_row)) == 1, paste0('0', ac(iter_row)), ac(iter_row))
          iter_date = paste0(iter_col_name, '-', iter_row_name)
          iter_call = Calls_df[iter_row, iter_col]
          Calls = append(Calls, iter_call)
          Date = append(Date, iter_date)
        } # row iteration
      } # col iteration

      # Get a vector of values and fix format ----
      Calls = unlist(Calls)
      Date = unlist(Date)
      Date = as.Date(Date)

      # Declare as a time series ----
      # Bind dates and calls per day
      data = data.frame(dates = Date, calls = Calls)
      # Removing na's
      data = na.omit(data)
      # Time series
      ts_data = xts(x = data$calls, order.by = data$dates, frequency = 1)
      # Remove trend
      diff_ts_data = diff(ts_data)

      # Name for each var
      #names(predictions) = bla

    } # var iteration

    # Name for each customer
    #names(predictions) = bla

  } # for each (customer)

  #return(predictions)
}
