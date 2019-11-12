
histogramDateTime = function(dataset){
  hist(as.POSIXct(dataset$closeDateTime), "days", format = "%d %b")
}
