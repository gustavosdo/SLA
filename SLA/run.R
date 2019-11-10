rm(list=ls())
gc()
.rs.restartR()
devtools::load_all()
fileName = '/home/luga/Dropbox/Git/DataScientistTest/dataset/ticket_cientista.csv'
preProcessedData = dataInspect(fileName = fileName)
hist(as.POSIXct(preProcessedData$closeDateTime), "weeks", format = "%d %b")
