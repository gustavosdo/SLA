#' @title Parameters of a linear regression using Bayesian methodology and MCMC
#' @name linearRegressionB
#'
#' @description In this function, a method of linear regression using
#' Bayesian theorem is developed. The objective is to finda the posteriori
#' probability P({c_n} | data) for c_1 and c_0 parameters using a Markov Chain
#' Monte Carlo.
#'
#' @param x A vector containing the predictor variable
#' @param y A vector containing the resultant variable
#'
#' @return Values of linear function parameters and its errors
#'
#' @import

linearRegressionB = function(x, y){

  # Frequentist linear regression ----------------------------------------------
  resF = linearRegressionF(x, y)

  # Bayesian linear regression -------------------------------------------------
  # P

  # Using random values to start the parameters
  c0 = dnorm(x = seq(from = -0, to = 20, by = 1), mean = 0, sd = 100)
  c1 = sample(x = -1000:1000, size = 1)
  sd = sample(x = -1000:1000, size = 1)

  #

}
