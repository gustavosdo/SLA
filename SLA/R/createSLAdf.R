#' @title Creates dataframe simiar to a calendar
#' @name createSLAdf
#'
#' @description This function generates a data frame with the date range
#' given by json config file or dataset
#'
#' @param cfg The json file containing all parameters.
#' @param dataset The dataset with the correct date object
#'
#' @return A dataframe where the rows are the days and each column is a month.
#'
#' @import jsonlite devtools

createSLAdf = function(cfg, dataset){

  # Data frame with all months
  if (cfg$pre_process$range_within_year){

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
  } else {
    # Getting month names from dataset
    months = unique(
      sapply(
        dataset[,cfg$pre_process$closeDate_col],
        function(x){substr(x,1,7)}
      )
    )
    # Ordering months to fill days data.frame
    months = months[order(months, decreasing = F)]
    # Creating days data.frame
    for (iter_month in months){
      if(exists('days')){
        iter_days = data.frame(rep(NA, 31))
        colnames(iter_days) = iter_month
        days = cbind(days, iter_days)
      } else {
        days = data.frame(rep(NA, 31))
        colnames(days) = iter_month
      }
    }
  }
  return(days)
}
