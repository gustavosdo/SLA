
linearRegressionTickets = function(dataset){

  # Linear regression
  linReg = linearRegressionF(x = dataset$x, y = dataset$y)
  a = linReg$coefficients[[1]]
  b = linReg$coefficients[[2]]
  a_err = summary(linReg)[4][[1]][[3]]
  b_err = summary(linReg)[4][[1]][[4]]

  # Define prediction for day
  prediction = round(a + an(substr(day, 9, 10))*b)

  # Statistical error calculation
  pred_error = round(sqrt((a_err)**2 + (an(substr(day, 9, 10))*b_err)**2))

  # Some kind of systematic error (TBD)

  # ticketsPredictions data frame
  if (!exists("ticketsPredictions")){
    ticketsPredictions = data.frame(customer = customer,
                                    variable = variable,
                                    day = day,
                                    value = prediction,
                                    error = pred_error)
  } else {
    ticketsPredictions = rbind(ticketsPredictions,
                               data.frame(customer = customer,
                                          variable = variable,
                                          day = day,
                                          value = prediction,
                                          error = pred_error))
  } # if-else

  return(ticketsPredictions)
}
