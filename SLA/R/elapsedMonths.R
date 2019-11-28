
# Function first seen on https://stackoverflow.com/questions/1995933/number-of-months-between-two-dates
elapsedMonths = function(start_date, end_date) {
  ed = as.POSIXlt(end_date)
  sd = as.POSIXlt(start_date)
  return(12 * (ed$year - sd$year) + (ed$mon - sd$mon))
}
