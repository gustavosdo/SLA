#' @title Parameters of a linear regression using Bayesian methodology and MCMC
#' @name linearRegressionB
#'
#' @description In this function, a method of linear regression using
#' Bayesian theorem is developed. The objective is to finda the posteriori
#' probability P({c_n} | data) for c_1 and c_0 parameters using a Markov Chain
#' Monte Carlo.
#'
#' @details Probability density function definitions were first seen at
#' https://theoreticalecology.wordpress.com/2010/09/17/metropolis-hastings-mcmc-in-r/
#'
#' @param x A vector containing the predictor variable
#' @param y A vector containing the resultant variable
#'
#' @return Values of linear function parameters and its errors
#'
#' @import reticulate

linearRegressionB = function(x, y, cfg){

  # Mean values of parameters from frequesntist linear regression --------------
  resF = linearRegressionF(x, y)
  # Unpacking resF variables
  for (i in 1:length(resF)) {assign(names(resF)[i], resF[[i]])}

  # Markov chain execution -----------------------------------------------------
  startValues = c(runif(n = 1, min = -200, max = 200),
                  runif(n = 1, min = -200, max = 200),
                  #runif(n = 1, min = c0 - c0_sd, max = c0 + c0_sd),
                  #runif(n = 1, min = c1 - c1_sd, max = c1 + c1_sd),
                  runif(n = 1, min = 0, cfg$process$bayes_sd))
  chain = MCMC(cfg = cfg,
               x = x, y = y,
               startValues = startValues,
               iters = cfg$process$bayes_nsteps,
               c0_sd = c0_sd,
               c1_sd = c1_sd,
               sd = cfg$process$bayes_sd)

  # Removing initial random entries
  chain = chain[-(1:cfg$process$mcmc_burnin),]
  # Optimal value of acceptance is from 20% to 30%
  acceptance = 1 - mean(duplicated(chain))

  # Parameters and its errors --------------------------------------------------
  c0 = mean(chain[,1]); c0_sd = sd(chain[,1])
  c1 = mean(chain[,2]); c1_sd = sd(chain[,2])
  f = function(c0, c1, x){return(c0 + c1*x)}

  # Calculating R²
  # Sum of squares of residuals
  SSres = sum((f(c0,c1,x) - y)**2)
  # Total sum of squares
  SStot = sum((y - mean(y))**2)
  # R-square
  R2 = 1 - SSres/SStot
  # Chi2 per number of degrees of freedom
  Chi2NDOF = SSres/(length(x)-2)

  # Return values of parameters ------------------------------------------------
  return(list(c0 = c0,
              c0_sd = c0_sd,
              c1 = c1,
              c1_sd = c1_sd,
              R2 = R2,
              Chi2NDOF = Chi2NDOF))

}
