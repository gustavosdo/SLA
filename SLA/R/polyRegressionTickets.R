
polyRegressionTickets = function(dataset, day, customer,
                                 variable, cfg, verbose){

  for (degree in cfg$process$poly_degree){
    if (cfg$process$use_poly_blackbox){
      if (!exists("ticketsPredictions")){
        ticketsPredictions = polyRegBox(customer = customer,
                                        variable = variable,
                                        dataset = dataset,
                                        degree = degree,
                                        day = day,
                                        verbose = verbose)
      } else {
        ticketsPredictions = rbind(ticketsPredictions,
                                   polyRegBox(customer = customer,
                                              variable = variable,
                                              dataset = dataset,
                                              degree = degree,
                                              day = day,
                                              verbose = verbose))
      } # if-else
    } # if blackbox models

    if (cfg$process$use_poly_selfmade){
      if(verbose){print("Self-made polynomial regression not available yet")}
    }

  } # Loop over degrees

  return(ticketsPredictions)
} # end function
