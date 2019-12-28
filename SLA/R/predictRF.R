#' @title Preview of number of calls and closed calls based on a random forest algorithm
#' @name predictRF
#'
#' @description This module receives the all calls and closed calls for a
#' given date range and returns the expected value of calls and closed calls
#' for another date range using random forest algorithm
#'
#' @param cfg A json with configuration data
#' @param data a dataframe with all the parameters and the target of processing
#'
#' @return solution A vector with the SLA preview done with random forest
#'
#' @import randomForest

predictRF = function(cfg, data){
  regressor = randomForest(x = data[1], y = data$calls, ntree = 100)
  previews = predict(regressor, newdata = c(27))
}
