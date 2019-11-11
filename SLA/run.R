rm(list=ls())
gc()
.rs.restartR()
devtools::load_all()
fileName = '../dataset/ticket_cientista.csv'
preProcessedData = dataInspect(fileName = fileName)
hist(as.POSIXct(preProcessedData$closeDateTime), "days", format = "%d %b")
