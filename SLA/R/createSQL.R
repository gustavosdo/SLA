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
#' @import RSQLite DBI

createSQL = function(cfg) {

  # SQL with cfg ---------------------------------------------------------------
  dbDriver = SQLite()
  con = dbConnect(dbDriver, ":memory:") #dbname = paste0(cfg$folders$database, "cfg"))
  dbWriteTable(conn = con, "cfg", 3)
  dbListTables(con)

  # Closing connection ---------------------------------------------------------
  dbDisconnect(con)
}
