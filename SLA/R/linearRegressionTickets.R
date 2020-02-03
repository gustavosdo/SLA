# Some kind of systematic error to be developed

linearRegressionTickets = function(dataset, day, customer,
                                   variable, cfg, verbose){

  # Linear regression: frequentist way -----------------------------------------
  if(cfg$process$frequentist_regression){
    if(verbose){print("Frequentist linear regressor")}
    # Result of linear regression using frequentist method
    resF = linearRegressionF(x = dataset$x, y = dataset$y)
    # Unpacking resF parameters
    for (i in 1:length(resF)) {assign(names(resF)[i], resF[[i]])}
    # Predict SLA for the given day
    prediction = round(c0 + an(substr(day, 9, 10))*c1)
    # Statistical error calculation
    pred_error = round(sqrt((c0_sd)**2 + (an(substr(day, 9, 10))*c1_sd)**2))

    # ticketsPredictions data frame
    ticketsPredictionsF = data.frame(customer = customer,
                                    variable = variable,
                                    day = day,
                                    value = prediction,
                                    error = pred_error,
                                    method = "linear_freq")
  }

  # Linear regression: bayesian way --------------------------------------------
  if(cfg$process$bayesian_regression){
    if(verbose){print("Bayesian linear regressor")}
    # Result of linear regression using frequentist method
    resB = linearRegressionB(x = dataset$x, y = dataset$y, cfg = cfg)
    # Unpacking resB parameters
    for (i in 1:length(resB)) {assign(names(resB)[i], resB[[i]])}
    # Predict SLA for the given day
    prediction = round(c0 + an(substr(day, 9, 10))*c1)
    # Statistical error calculation
    pred_error = round(sqrt((c0_sd)**2 + (an(substr(day, 9, 10))*c1_sd)**2))

    # ticketsPredictions data frame
    if (exists("ticketsPredictionsF")){
      ticketsPredictions = rbind(ticketsPredictionsF,
                                    data.frame(customer = customer,
                                               variable = variable,
                                               day = day,
                                               value = prediction,
                                               error = pred_error,
                                               method = "linear_bayes"))
    } else {
      ticketsPredictions = data.frame(customer = customer,
                                       variable = variable,
                                       day = day,
                                       value = prediction,
                                       error = pred_error,
                                       method = "linear_bayes")
    }
  }
  return(ticketsPredictions)
}
