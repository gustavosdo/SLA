#' @title SQL database with the configurations
#' @name createSQL
#'
#' @description This function is used in order to create a SQL database
#' using the configuration input
#'
#' @param cfg A list with the configurations
#'
#' @return None
#'
#' @import DBI dplyr dbplyr odbc RSQLite

createSQL = function(cfg) {

  # Open SQL connection
  con = dbConnect(RSQLite::SQLite(), ":memory:")

  # Create new table in database
  dbExecute(con,'
  create table Parameters (
  Name int,
  Value varchar(255)
  )
')

}
