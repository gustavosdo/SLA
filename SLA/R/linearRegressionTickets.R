# Some kind of systematic error to be developed

linearRegressionTickets = function(dataset, day, customer,
                                   variable, cfg, verbose){

  # Linear regression: self-made algorithms ------------------------------------
  if(cfg$process$use_linear_selfmade){
    # Frequentist model
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

    # Bayesian model
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
      } # if-else exists ticketsPredictionsF
    } # if bayesian model required
  } # if self-made

  if (cfg$process$use_linear_blackbox){
    if(verbose){print("Linear blackbox models not available yet")}
  }

  return(ticketsPredictions)
} # end function
