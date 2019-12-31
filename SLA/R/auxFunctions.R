#' @title General functions used throughout the analysis
#' @name auxFunctions
#'
#' @description A collection of useful functions (and some aliases)
#'

# Defining alias for as.character
ac = function(x){as.character(x)}

# Defining alias for as.numeric
an = function(x){as.numeric(x)}

# Defining function to determine if the year is bissextile/leap
isBissextile = function(x){
  if (!is.numeric(x)){ x = as.numeric(x) }
  char_x = ac(x)
  if ( xor ( (substr(char_x, 3, 4) == '00') & ((x %% 400) == 0) , (substr(char_x, 3, 4) != '00') & ((x %% 4) == 0)) )
  {
    return(T)
  } else {
    return(F)
  }
}

# Function first seen on https://stackoverflow.com/questions/1995933/number-of-months-between-two-dates
elapsedMonths = function(start_date, end_date) {
  ed = as.POSIXlt(end_date)
  sd = as.POSIXlt(start_date)
  return(12 * (ed$year - sd$year) + (ed$mon - sd$mon))
}

translateWeekDays = function(weekDays){
  pt_br_days = c("segunda", "terça", "quarta", "quinta", "sexta", "sábado", "domingo")
  en_days = c("monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday")

  return(unlist(lapply(weekDays, function(day){en_days[which(pt_br_days == day)]})))
}
