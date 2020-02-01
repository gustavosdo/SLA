#' @title Preview of number of calls and closed calls based on various algorithms
#' @name ticketsPredictions
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
#' @import

predictions = function(cfg, customersData, verbose = T){

  # Unpacking customersData ----
  customersData = unlist(customersData, recursive = F)

  # Customers to be included in the ticketsPredictions ----
  customers = cfg$process$customers
  if (is.null(customers)){customers = names(customersData)}

  # Variables (targets) to be included in the prediction ----
  variables = c("closeds", "allTickets")

  # Work days and weekend (for line 69)
  workdays = c("monday", "tuesday", "wednesday", "thursday", "friday")
  weekend = c("saturday", "sunday")

  # Parallel loop over customers ----
  for (customer in customers) {
    # Loop over variables ----
    for (variable in variables){
      # Data frame of a specific variable and customer
      Calls_df = customersData[customer][[1]][variable][[1]]
      # Vector of number of calls per day
      calls = na.omit(as.numeric(unlist(sapply(colnames(Calls_df),
                                               function(x){Calls_df[x]}))))
      # All days between start and end of date range
      dates = seq(from = as.Date(cfg$pre_process$initial_date),
                  to = as.Date(cfg$pre_process$end_date), by = "day")

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
          iter_data = data[data$weekdays %in% workdays,]
        } else if (weekday == "saturday"){
          iter_data = data[data$weekdays == "saturday",]
        } else {
          iter_data = data[data$weekdays == "sunday",]
        }

        # Creating data for linear regression
        iter_data = data.frame(x = an(substr(iter_data$dates, 9, 10)),
                               y = iter_data$calls)


        if(verbose){print(paste("Predicting: customer:", customer,
                                "; variable:", variable, "; day:", day))}

        # Linear regression ----
        if (cfg$process$linear_regression){
          # Linear regression modules
          if (!exists("ticketsPredictions")){
            ticketsPredictions = linearRegressionTickets(dataset = iter_data,
                                                         day = day,
                                                         customer = customer,
                                                         variable = variable,
                                                         cfg = cfg)
          } else {
            ticketsPredictions = rbind(ticketsPredictions,
                                        linearRegressionTickets(
                                          dataset = iter_data,
                                          day = day,
                                          customer = customer,
                                          variable = variable,
                                          cfg = cfg))
          } # if-else
        } # linear regression if

        # Polynomial regression ----
        if (cfg$process$poly_regression){
          polyReg = polyRegression(dataset = iter_data,
                                   degree = cfg$process$poly_degree)
        }

      } # day prediction iteration
    } # var iteration
  } # customer iteration

  # Save ticketsPredictions (for debug purpose)
  # Save the values for each day and customer
  save(ticketsPredictions,
       file = paste0(cfg$folders$processed, 'ticketsPredictions.RData'))

  # Predicting SLA for all days defined in JSON
  SlaPredictions = predictSLA(ticketsPredictions = ticketsPredictions)
  return(SlaPredictions)
}
