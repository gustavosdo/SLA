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
  table(is.na(dataset))

  # Variables names
  variables = colnames(dataset)
}
