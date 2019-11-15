# Variables names
#vars = colnames(dataset)

# SLA status
#slaStatus = unique(dataset$slaStatus)

# Call status
#callStatus = unique(dataset$callStatus)

# Was solved on time?
#onTimeStatus = unique(dataset$onTimeSolution)
# how many?
#nOnTime = length(dataset$onTimeSolution[dataset$onTimeSolution == 'S'])
# what is the percentage of total of calls?
#pOnTime = nOnTime/length(dataset$onTimeSolution)

# How is the time distribution of solved calls? The solved calls are defined below
#solvedCalls  = dataset[dataset$callStatus %in% c('N0', 'N4', 'CV'),]

# Only not null close date time entries
#notNullDate = dataset[dataset$closeDateTime != 'null',]
# Solved calls of notNullDate
#notNullSolved = notNullDate[notNullDate$callStatus %in%c('N0', 'N4', 'CV'),]



# rm(list=ls())
# gc()
# devtools::load_all()
# fileName = '../dataset/ticket_cientista.csv'
# dataset = defData(dataset_filename = fileName)
# customers = customerCodes(dataset)
# preProcessedData = harmonizeDateTime(dataset)
# histogramDateTime(preProcessedData)
