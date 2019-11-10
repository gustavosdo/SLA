dataInspect = function(){

  # define dataset
  fileName = '/home/luga/Dropbox/Git/DataScientistTest/dataset/ticket_cientista.csv'
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
  charDateTime = gsub ( x = gsub(x = as.character(notNullSolved$closeDateTime), pattern = 'ISODate', replacement = '') , replacement = '', pattern = "\"")
  charDateTime = gsub(x = charDateTime, pattern = "\\(", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "\\)", replacement = '')
  notNullSolved$closeDateTime = charDateTime

  # Checking the daylight saving time entries
  for (iter_n in 1:dim(notNullSolved)[1]){
    iter_row = notNullSolved[iter_n,]
    charTime = iter_row$closeDateTime
    if (substr(x = charTime, start = 26, stop = 26) == '2'){
      print(charTime)
    }
  }

  #
  #hist(dataset$closeDateTime, "year", freq = T)
}
