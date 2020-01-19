
accuracy = function(customersData, solutionsTest, dayTest, cfg)
{

  # Unpack all real solutions (customersData) ----------------------------------
  rData = unlist(customersData, recursive = F)

  # Customers to be included in the ticketsPredictions
  customers = cfg$process$customers
  if (is.null(customers)){customers = names(rData)}

  # Lists of accuracy tests
  tTest = list()
  relAcc = list()

  # Load the SLA (real and predicted) for each customer
  for (customer in customers){

    # Predicted SLA ------------------------------------------------------------
    pSLA = subset(x = solutionsTest$value,
                  subset = ((solutionsTest$customer == customer) &
                                  (solutionsTest$day == dayTest)))
    pSLAerror = subset(x = solutionsTest$error,
                       subset = ((solutionsTest$customer == customer) &
                                   (solutionsTest$day == dayTest)))

    # Real SLA (determined from original sample) -------------------------------
    rSLAdf = rData[customer][[1]]["SLAs"][[1]]
    rSLA = rSLAdf[an(substr(x = dayTest, start = 9, stop = 10)),
                        substr(x = dayTest, start = 1, stop = 7)]

    # Student's t test-like (t' = (A-B) / sqrt(deltaA**2 + deltaB**2)) ---------
    tTest[[customer]] = abs(rSLA - pSLA)/pSLAerror

    # Relative accuracy (D = (A-B)/A) ------------------------------------------
    relAcc[[customer]] = abs(rSLA - pSLA)/rSLA
  }

  # List with both of accuracy tests -------------------------------------------
  accTests = list(relAcc = relAcc, tTest = tTest)
  return(accTests)
}
