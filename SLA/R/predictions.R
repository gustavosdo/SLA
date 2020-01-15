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

  # Work days and weekend (for line 69)
  workdays = c("monday", "tuesday", "wednesday", "thursday", "friday")
  weekend = c("saturday", "sunday")

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

      # Define data ----
      # Bind dates and calls per day
      data = data.frame(weekdays = weekDays, dates = dates, calls = calls)
      # Removing na's
      data = na.omit(data)

      # Prediction ----
      for (day in cfg$process$days_prediction){
        weekday = translateWeekDays(as.list(weekdays(as.Date(day))))
        if (weekday %in% workdays){
          data = data[data$weekdays %in% workdays,]
        } else if (weekday == "saturday"){
          data = data[data$weekdays == "saturday",]
        } else {
          data = data[data$weekdays == "sunday",]
        }

        # Creating data for linear regression
        data = data.frame(x = an(substr(data$dates, 9, 10)), y = data$calls)

        # Linear regression
        linReg = lm(y~x, data) # y = a + b*x
        a = linReg$coefficients[[1]]
        b = linReg$coefficients[[2]]
        a_err = summary(linReg)[4][[1]][[3]]
        b_err = summary(linReg)[4][[1]][[4]]

        # Define prediction for day
        prediction = round(a + an(substr(day, 9, 10))*b)

        # Statistical error calculation
        pred_error = round(sqrt( (a_err)**2 + (an(substr(day, 9, 10))*b_err)**2))

        # Some kind of systematic error (TBD)
      }

    } # var iteration

    # Name for each customer
    #names(predictions) = bla

  } # for each (customer)

  #return(predictions)
}
