library(doParallel)
library(foreach)

dataInspect = function(fileName = NULL){

  # define dataset
  dataset = defData(dataset_filename = fileName)

  # Variables names
  vars = colnames(dataset)

  # Customer codes
  customerCodes = dataset$customerCode
  customers = unique(customerCodes)
  nCustomers = length(customers)

  # SLA status
  slaStatus = unique(dataset$slaStatus)

  # Call status
  callStatus = unique(dataset$callStatus)

  # Was solved on time?
  onTimeStatus = unique(dataset$onTimeSolution)
  # how many?
  nOnTime = length(dataset$onTimeSolution[dataset$onTimeSolution == 'S'])
  # what is the percentage of total of calls?
  pOnTime = nOnTime/length(dataset$onTimeSolution)

  # How is the time distribution of solved calls? The solved calls are defined below
  solvedCalls  = dataset[dataset$callStatus %in% c('N0', 'N4', 'CV'),]

  # Only not null close date time entries
  notNullDate = dataset[dataset$closeDateTime != 'null',]
  # Solved calls of notNullDate
  notNullSolved = notNullDate[notNullDate$callStatus %in%c('N0', 'N4', 'CV'),]

  # Converting date time format
  charDateTime = gsub(x = gsub(x = as.character(notNullSolved$closeDateTime), pattern = 'ISODate', replacement = '') , replacement = '', pattern = "\"")
  charDateTime = gsub(x = charDateTime, pattern = "\\(", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "\\)", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "T", replacement = ' ')
  notNullSolved$closeDateTime = charDateTime

  # Slicing the strings of closeDateTime
  notNullSolved$closeDateTime = sapply(notNullSolved$closeDateTime, function(x){substr(x = x, start = 1, stop = 19)})

  return(notNullSolved)
}
