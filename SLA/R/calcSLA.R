
calcSLA = function(dataset, cfg){

  # Remember to select customer before all this processing!!!!

  # Getting the vector of date/time of closure
  colTime = cfg$pre_process$closeDate_col
  closedDateTime = dataset[colTime]

  # ALL CODE BELOW MUST BE REFACTORED
  # IT IS ASSUMING THAT ALL MONTHS FOR ALL YEARS ARE RELEVANT (WHICH CAN BE FALSE)

  # # Checking years of interest
  # n_years = length(seq(from = as.Date(cfg$pre_process$initial_date), to = as.Date(cfg$pre_process$end_date), by = 'year'))
  # initial_year = as.numeric(substr(cfg$pre_process$initial_date, 1, 4))
  # years = sapply(0:(n_years-1), function(x){initial_year + x})
  # # Check how many months ...
  # n_months = length(seq(from = as.Date(cfg$pre_process$initial_date), to = as.Date(cfg$pre_process$end_date), by = 'month'))
  # initial_month = substr(cfg$pre_process$initial_date, 6, 7)
  # months = sapply(as.numeric(initial_month):n_months, function(x){month.name[x]})
  # # ... and how many days for each month are there
  # days = sapply(1:(n_months*n_years), function(x){0})
  # month_year = expand.grid(as.character(years), months) ;
  # colnames(month_year) = c('year', 'month')
  # for (iter_row in 1:nrow(month_year)){
  #   iter_month = paste0(month_year[iter_row,1], '-', month_year[iter_row,2])
  #   # Get the initial day for each month of each year [NOT WORKING!]
  #   iter_list = sapply(closedDateTime$closeDateTime,
  #                      function(x){if (substr(x, 1, 7) == iter_month) {
  #                                                                       substr(x, 9, 10) } else { NULL } })
  #   #min(as.character.Date(iter_list))
  # }

  # n = Month sum of number of tickets closed on time (onTimeSolution = S; callStatus = N0, N4 or CV) per day
  #n_jan = rep(0, 31)
  #n_feb = rep(0, 31)

  # N = Month sum of number of tickets closed per day (callStatus = N0, N4 or CV)

  # SLA = n/N

  # Vector of days

  # Data frame with dates and SLA's

  # Return the data frame to proceed to processing
}
