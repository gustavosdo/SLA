
createSLAdf = function(cfg){

  # Date range from cfg
  ini_date = cfg$pre_process$initial_date
  end_date = cfg$pre_process$end_date

  # Quantity of different months between dates
  months = elapsedMonths(ini_date, end_date) + 1

  # Years of data taking start
  ini_year = substr(ini_date, 1, 4)
  end_year = substr(end_date, 1, 4)

  # Quantity of different years between dates
  years = an(end_year) - an(ini_year) + 1

  # Month of data taking start
  ini_month = substr(ini_date, 6, 7)

  # Day of data taking start
  ini_day = substr(ini_date, 9, 10)

  # Data frame with all months
  for (year in 1:years){
    year = ac(an(ini_year) + year - 1)
    for (month in 1:months){
      month = ifelse( nchar(ac(month)) == 1, paste0('0', ac(an(ini_month) + month - 1)), ac(an(ini_month) + month - 1))
      if(exists('days')){
        iter_days = data.frame(rep(NA, 31))
        colnames(iter_days) = paste0(year, '-', month)
        days = cbind(days, iter_days)
      } else {
        days = data.frame(rep(NA, 31))
        colnames(days) = paste0(ini_year, '-', ini_month)
      }
    }
  }
  return(days)
}
