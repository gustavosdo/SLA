
harmonizeDateTime = function(dataset){

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

  # Only not null close date time entries
  dataset = dataset[dataset$closeDateTime != 'null',]

  # Converting date time format
  charDateTime = gsub(x = gsub(x = as.character(dataset$closeDateTime), pattern = 'ISODate', replacement = '') , replacement = '', pattern = "\"")
  charDateTime = gsub(x = charDateTime, pattern = "\\(", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "\\)", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "T", replacement = ' ')

  # Slicing the strings of closeDateTime
  charDateTime = sapply(charDateTime, function(x){substr(x = x, start = 1, stop = 19)})

  # returns the harmonized date/time set to original dataset
  dataset$closeDateTime = charDateTime

  # removes the entry solved from 2017
  dataset = dataset[order(dataset$closeDateTime),]
  dataset = dataset[-c(1),]

  return(dataset)
}
