
predictSLA = function(ticketsPredictions){

  # Loop over days of prediction ----
  for (iter_day in unique(ticketsPredictions$day)){
    iter_data = ticketsPredictions[as.Date(ticketsPredictions$day)
                                   == as.Date(iter_day),]
    # Loop over methods
    for (iter_method in unique(iter_data$method)){
      method_data = iter_data[ac(iter_data$method) == ac(iter_method),]
      # Loop over customers ----
      for (customer in unique(method_data$customer)){
        customer_data = method_data[ac(method_data$customer) == ac(customer),]

        # Calculating SLA and its associated error ----
        # Prediction of closed tickets
        C = customer_data$value[customer_data$variable == "closeds"]
        # Prediction of all tickets
        A = customer_data$value[customer_data$variable == "allTickets"]
        # Error of C
        sigmaC = customer_data$error[customer_data$variable == "closeds"]
        # Error of A
        sigmaA = customer_data$error[customer_data$variable == "allTickets"]

        # Service Level Agreement prediction and its error
        sla = C/A; sigma_sla = sla*sqrt( (sigmaC/C)**2+ (sigmaA/A)**2 )

        # Creating predictions object ----
        if (!exists("Sla")){
          Sla = data.frame(customer = customer,
                           day = iter_day,
                           method = iter_method,
                           value = sla,
                           error = sigma_sla)
        } else {
          Sla = rbind(Sla, data.frame(customer = customer,
                                      day = iter_day,
                                      method = iter_method,
                                      value = sla,
                                      error = sigma_sla))
        } # if-else
      } # customers loop
    } # method loop
  } # day loop

  return(Sla)
}
