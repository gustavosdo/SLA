
calcCustomerSLA = function(dataset, cfg){

  # Adjusting types
  dataset[,cfg$pre_process$closeDate_col] = as.character(dataset[,cfg$pre_process$closeDate_col])

  # Vector of SLA for each day
  days = seq(from = as.Date(cfg$pre_process$initial_date), to = as.Date(cfg$pre_process$end_date), by = 'day')
  res = as.list(rep(0, length(days)))
  names(res) = days

  for (iter_day in names(res)[1:length(days)]){
    closed_classes = c('N0', 'N4', 'CV')
    closed_ptr = which(dataset[,cfg$pre_process$closed_ticket_col] %in% closed_classes)
    time_ptr = dataset[,cfg$pre_process$closed_ontime_col] == 'S'
    iter_ptr = dataset[,cfg$pre_process$closeDate_col] <= paste(iter_day, '23:59:59')
    # Subset dataset
    #
    # Calculate n (total of closed tickets (in time) until iter_day)
    #n = length()
    # Calculate N (total of tickets until iter_day)
    #N = length()
    # calculate the SLA
    #res[iter_day] = n/N
  }

  return(res)
}
