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
#' @import parallel foreach doParallel fpp2

predictions = function(cfg, customersData){

  # Unpacking customersData ----
  customersData = unlist(customersData, recursive = F)

  # Customers to be included in the predictions ----
  customers = cfg$process$customers
  if (is.null(customers)){customers = names(customersData)}

  # Variables (targets) to be included in the prediction ----
  variables = c("closeds", "allTickets")

  # Parallel loop over customers ----
  foreach (customer = customers[1:length(customers)], .packages = c('devtools'), .export = c("variables", "customersData")) %dopar% {
    load_all()
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
      #dates = data$dates # use plot(x = dates, y = c(0,diff_data)) to plot the difference
      # Days sequence
      days = seq(as.Date(data$dates[1],"$Y-$M-$D"), as.Date(data$dates[length(data$dates)], "$Y-$M-$D"), by = "day")
      start_year = an(substr(x = data$dates[1], start = 1, stop = 4))
      # Time series
      data = ts(data = data$calls, start = c(start_year, as.numeric(format(days[1], "%j"))), frequency = 365)
      # Remove trend
      diff_data = diff(data)
      # Benchmark models
      fit = snaive(diff_data)
      summary(fit)
      checkresiduals(fit)
      fit_ets = ets(data)
      summary(fit_ets)
      checkresiduals(fit_ets)
      fit_arima = auto.arima(data)#, d = 1, D = 1, stepwise = F, approximation = F, trace = T)
      summary(fit_arima)
      checkresiduals(fit_arima)

      # Predictions ----
      #predictions = list()
      #if("arima" %in% cfg$process$models){predictions = append(predictions, arima(data))}



      # Name for each var
      #names(predictions) = bla

    } # var iteration

    # Name for each customer
    #names(predictions) = bla

  } # for each (customer)

  #return(predictions)
}
