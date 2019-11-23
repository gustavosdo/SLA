
calcSLA = function(dataset, cfg){

  # Getting the vector of date/time of closure
  colTime = cfg$pre_process$closeDate_col
  closedDateTime = dataset[colTime]

  # Check how many months ...
  n_months = length(seq(from = as.Date(cfg$pre_process$initial_date), to = as.Date(cfg$pre_process$end_date), by = 'month'))
  initial_month = as.numeric(substr(cfg$pre_process$initial_date, 6, 7))
  months = sapply(initial_month:n_months, function(x){month.name[x]})
  # ... and how many days for each month are there
  days = rep(0, n_months)

  # n = Month sum of number of tickets closed on time (onTimeSolution = S; callStatus = N0, N4 or CV) per day
  #n_jan = rep(0, 31)
  #n_feb = rep(0, 31)

  # N = Month sum of number of tickets closed per day (callStatus = N0, N4 or CV)

  # SLA = n/N

  # Vector of days

  # Data frame with dates and SLA's

  # Return the data frame to proceed to processing
}
