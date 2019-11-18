
calc_SLA = function(dataset, cfg){

  # Getting the vector of date/time of closure
  colTime = cfg$pre_process$closeDate_col
  closedDateTime = dataset[colTime]

  # n = Month sum of number of tickets closed on time (onTimeSolution = S; callStatus = N0, N4 or CV) per day

  # N = Month sum of number of tickets closed per day (callStatus = N0, N4 or CV)

  # SLA = n/N

  # Vector of days

  # Data frame with dates and SLA's

  # Return the data frame to proceed to processing
}
