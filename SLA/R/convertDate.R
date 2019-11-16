
convertDate = function(dataset, cfg){

  # Only not null close date time entries
  colTime = cfg$pre_process$closeDate_col
  dataset = dataset[dataset[colTime] != 'null',]

  ##### APPLY PIPE IN THE GSUB'S ---------

  # Converting date time format
  charDateTime = gsub(x = gsub(x = as.character(dataset[,colTime]), pattern = 'ISODate', replacement = '') , replacement = '', pattern = "\"")
  charDateTime = gsub(x = charDateTime, pattern = "\\(", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "\\)", replacement = '')
  charDateTime = gsub(x = charDateTime, pattern = "T", replacement = ' ')

  # Slicing the strings of closeDateTime
  charDateTime = sapply(charDateTime, function(x){substr(x = x, start = 1, stop = 19)})

  # returns the harmonized date/time set to original dataset
  dataset[colTime] = charDateTime


  ###### FIX HERE! ----

  # removes the entry solved from 2017
  dataset = dataset[order(dataset$closeDateTime),]
  dataset = dataset[-c(1),]

  return(dataset)
}
