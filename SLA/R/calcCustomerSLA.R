
calcCustomerSLA = function(dataset, cfg){

  # Adjusting types
  dataset[,cfg$pre_process$closeDate_col] = as.character(dataset[,cfg$pre_process$closeDate_col])

  # Date range from cfg
  ini_date = cfg$pre_process$initial_date
  end_date = cfg$pre_process$end_date

  # Vector of SLA for each year, month and day
  days = createSLAdf(cfg)

  for (iter_col in 1:ncol(days))
  {
    iter_name = names(days)[iter_col]
    for (iter_day in 1:nrow(days)){
      day = ifelse( nchar(ac(iter_day)) == 1, paste0('0', ac(iter_day)), ac(iter_day))
      date = paste0(iter_name, '-', day)
      if ((date >= ini_date) & (date <= end_date)){
        # All tickets until the day
        closeDateCol = cfg$pre_process$closeDate_col
        iter_ptr = dataset[,closeDateCol] <= paste(date, '23:59:59') & dataset[,closeDateCol] >= paste0(iter_name, '-01 00:00:00')
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
        days[iter_day, iter_col] = ifelse(N == 0, 0, n/N)
      }
    }
  }
  return(days)
}
