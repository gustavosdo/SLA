
predictSLA = function(ticketsPredictions){

  # Loop over days of prediction ----
  for (iter_day in unique(ticketsPredictions$day)){
    iter_data = ticketsPredictions[as.Date(ticketsPredictions$day) == as.Date(iter_day),]

    # Loop over customers ----
    for (customer in unique(iter_data$customer)){
      #customer = unique(ac(data$customer))[3]

      customer_data = iter_data[ac(iter_data$customer) == ac(customer),]

      # Calculating SLA and its associated error ----
      C = customer_data$value[customer_data$variable == "closeds"] # Prediction of closed tickets
      A = customer_data$value[customer_data$variable == "allTickets"] # Prediction of all tickets
      sigmaC = customer_data$error[customer_data$variable == "closeds"] # Error of C
      sigmaA = customer_data$error[customer_data$variable == "allTickets"] # Error of A

      # Service Level Agreement prediction and its error
      sla = C/A; sigma_sla = sla*sqrt( (sigmaC/C)**2+ (sigmaA/A)**2 )

      # Creating predictions object ----
      if (!exists("Sla")){
        Sla = data.frame(customer = customer, day = iter_day, value = sla, error = sigma_sla)
      } else {
        Sla = rbind(Sla, data.frame(customer = customer, day = iter_day, value = sla, error = sigma_sla))
      }
    }
  }

  return(Sla)
}
