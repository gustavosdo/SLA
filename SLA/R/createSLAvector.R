
createSLAvector = function(cfg){

  # Date range from cfg
  ini_date = as.Date(cfg$pre_process$initial_date)
  end_date = as.Date(cfg$pre_process$end_date)

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
  days = list(rep(NA, years))

  for (year in 1:years){
    year = ac(an(ini_year) + year - 1)
    for (month in 1:months){
      month = ifelse( nchar(ac(month)) == 1, paste0('0', ac(an(ini_month) + month - 1)), ac(an(ini_month) + month - 1))
      for (day in 1:31){
        day = ifelse( nchar(ac(day)) == 1, paste0('0', ac(day)), ac(day) )
        date = as.Date(paste0(year, '-', month, '-', day))
        if ( (date >= ini_date) & (date <= end_date) ){
        }
      }
    }
  }
}
