
library(fields)

polyRegBox = function(customer, variable, dataset,
                          degree, day, verbose){

  if(verbose){print(paste("Polynomial regressor. Degree = ", degree))}
  # Original data --------------------------------------------------------------
  x = dataset$x
  y = dataset$y
  # Building regression function -----------------------------------------------
  model = lm(formula = y~poly(x = x, degree = degree))
  # Predict SLA for the given day ----------------------------------------------
  prediction = predict(object = model,
                       data.frame(x = an(substr(x = day, start = 9, stop = 10))),
                       se.fit = T)

  # ticketsPredictions data frame
  ticketsPredictions = data.frame(customer = customer,
                                  variable = variable,
                                  day = day,
                                  value = prediction$fit[[1]],
                                  error = prediction$se.fit[[1]],
                                  method = paste0("poly_degree_", degree))
  return(ticketsPredictions)
}
