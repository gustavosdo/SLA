rm(list=ls())
gc()
.rs.restartR()
devtools::load_all()
fileName = '../dataset/ticket_cientista.csv'
dataset = defData(dataset_filename = fileName)
customers = customerCodes(dataset)
preProcessedData = harmonizeDateTime(dataset)
histogramDateTime(preProcessedData)
