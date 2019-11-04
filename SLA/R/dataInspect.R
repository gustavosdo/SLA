dataInspect = function(){

  # define dataset
  filename = '/home/luga/Dropbox/Git/DataScientistTest/dataset/ticket_cientista.csv'
  dataset = defData(dataset_filename = filename)

  # Simple metrics
  #head(dataset)
  #hist(dataset$attendanceType)
  #hist(dataset$averageRepairTime)
  #summary(dataset$averageRepairTimeType)

  # Find all NA's
  #table(is.na(dataset))

  # Find the indices of NA's

  # Variables names
  variables = colnames(dataset)
  'customerCode' %in% variables

  # Customer codes
  customer_codes = dataset$customerCode
  customers = unique(customer_codes)
  n_customers = length(customers)

  # SLA status
  sla_status = unique(dataset$slaStatus)

  # Call status
  call_status = unique(dataset$callStatus)

  # Was solved on time?
  onTime_status = unique(dataset$onTimeSolution)
  # how many?
  n_ontime = length(dataset$onTimeSolution[dataset$onTimeSolution == 'S'])
  # what is the percentage of total of calls
  p_ontime = n_ontime/length(dataset$onTimeSolution)

  # How is the time distribution of solved calls?
  solved_calls = dataset[dataset$callStatus %in% c('N0', 'N4', 'CV'),]
  #hist(dataset$closeDateTime)
}
