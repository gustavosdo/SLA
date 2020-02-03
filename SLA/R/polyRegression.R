
library(fields)

polyRegression = function(customer, variable, dataset, degree, day){

  # Original data --------------------------------------------------------------
  x = dataset$x
  y = dataset$y
  # Building regression function -----------------------------------------------
  model = lm(formula = y~poly(x = x, degree = degree))
  # Predict SLA for the given day ----------------------------------------------
  prediction = predict(object = model, data.frame(x = day), se.fit = T)

  # ticketsPredictions data frame
  ticketsPredictions = data.frame(customer = customer,
                                  variable = variable,
                                  day = day,
                                  value = prediction$fit[[1]],
                                  error = prediction$se.fit[[1]],
                                  method = "polynomial")
  return(ticketsPredictions)
}
