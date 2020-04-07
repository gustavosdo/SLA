#' @title A SQL with the json configuration
#' @name createSQL
#'
#' @description This function is used in order to create a SQL database
#' using the jsoin configuration input
#'
#' @param cfg The json configuration file read by jsonlite::fromJSON function
#'
#' @return A SQL database address (it saves the SQL too)
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

  # OLD CODE
  # # SQL with cfg ---------------------------------------------------------------
  # dbDriver = SQLite()
  # con = dbConnect(dbDriver, ":memory:") #dbname = paste0(cfg$folders$database, "cfg"))
  # dbWriteTable(conn = con, "cfg", 3)
  # dbListTables(con)
  #
  # # Closing connection ---------------------------------------------------------
  # dbDisconnect(con)
}
