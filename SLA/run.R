rm(list=ls())
gc()
devtools::load_all()
fileName = '../dataset/ticket_cientista.csv'
dataset = defData(dataset_filename = fileName)
customers = customerCodes(dataset)
preProcessedData = harmonizeDateTime(dataset)
histogramDateTime(preProcessedData)

SLA = function(filename = NULL, customer = NULL)
