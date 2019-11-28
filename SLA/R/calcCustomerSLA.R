
calcCustomerSLA = function(dataset, cfg){

  # Adjusting types
  dataset[,cfg$pre_process$closeDate_col] = as.character(dataset[,cfg$pre_process$closeDate_col])

  # Vector of SLA for each year, month and day
  days = createSLAvector(cfg)

  # if (substr(cfg$pre_process$initial_date, 1, 4) < substr(cfg$pre_process$end_date, 1, 4)){
  #   years = as.numeric(substr(cfg$pre_process$end_date, 1, 4)) - as.numeric(substr(cfg$pre_process$initial_date, 1, 4)) + 1
  # } else {
  #   years = 1
  # }
  # years_names = as.character(
  #   sapply(1:years,
  #          function(x){
  #            as.numeric(substr(cfg$pre_process$initial_date, 1, 4)) + x - 1
  #          }
  #   )
  # )
  #
  # # number of months between initial and end dates
  # months = elapsedMonths(cfg$pre_process$initial_date, cfg$pre_process$end_date)
  # # names of each month
  # month_names = month.name[as.numeric(substr(cfg$pre_process$initial_date, 6, 7)):(months+1)]
  #
  # # vector of days by each month
  # days = as.list(rep(NA, length(months)+1))
  # names(days) = month_names
  # days = sapply(days, function(x){seqDays(x)})
  #
  # days = seq(from = as.Date(cfg$pre_process$initial_date), to = as.Date(cfg$pre_process$end_date), by = 'day')
  # res = as.list(rep(NA, length(days)))
  # names(res) = days

  for (iter_day in names(res)[1:length(days)]){
    # All tickets until the day
    iter_ptr = dataset[,cfg$pre_process$closeDate_col] <= paste(iter_day, '23:59:59')
    iter_dataset = dataset[iter_ptr,]
    # Calculate N (total of tickets until iter_day)
    N = dim(iter_dataset)[1]
    # Pointers
    closed_ptr = iter_dataset[,cfg$pre_process$closed_ticket_col] %in% c('N0', 'N4', 'CV') # closed tickets
    iter_dataset = iter_dataset[closed_ptr,]
    time_ptr = iter_dataset[,cfg$pre_process$closed_ontime_col] %in% c('S') # closed on time (on SLA)
    iter_dataset = iter_dataset[time_ptr,]
    # Calculate n (total of closed tickets (in time) until iter_day)
    n = dim(iter_dataset)[1]
    # calculate the SLA
    res[iter_day] = ifelse(N == 0, 0, n/N)
  }
  return(res)
}
