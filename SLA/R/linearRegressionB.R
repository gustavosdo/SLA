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
#' @import reticulate

linearRegressionB = function(x, y){

  # summary statistics of sample
  n    = length(x)
  ybar = mean(y)
  s2   = mean(x**2) - mean(x)**2

  # sample from the joint posterior (mu, tau | data)
  mu     = rep(NA, 11000)
  tau    = rep(NA, 11000)
  T      = 1000    # burnin
  tau[1] = 1  # initialisation
  for(i in 2:11000) {
    mu[i]  = rnorm(n = 1, mean = ybar, sd = sqrt(1 / (n * tau[i - 1])))
    tau[i] = rgamma(n = 1, shape = n / 2, scale = 2 / ((n - 1) * s2 + n * (mu[i] - ybar)^2))
  }
  mu  = mu[-(1:T)]   # remove burnin
  tau = tau[-(1:T)] # remove burnin

  # # Frequentist linear regression ----------------------------------------------
  # resF = linearRegressionF(x, y)
  # # Unpacking results
  # c0_mean = resF$c0; c0_sd = resF$c0_sd
  # c1_mean = resF$c1; c1_sd = resF$c1_sd
  # var = resF$Chi2NDOF
  #
  # # Bayesian linear regression -------------------------------------------------
  # # Prior distributions based on frequentist result
  # c0 = dnorm(x = seq(from = c0_mean - 3 * c0_sd,
  #                    to = c0_mean + 3 * c0_sd,
  #                    by = 6*c0_sd/cfg$process$bayes_nsteps),
  #            mean = c0_mean,
  #            sd = c0_sd)
  # c1 = dnorm(x = seq(from = c1_mean - 3 * c1_sd,
  #                    to = c1_mean + 3 * c1_sd,
  #                    by = 6*c1_sd/cfg$process$bayes_nsteps),
  #            mean = c1_mean,
  #            sd = c1_sd)
  # sd_range_max = max(c1_mean + 3 * c1_sd, c0_mean + 3 * c0_sd)
  # sd = dnorm(x = seq(from = 0,
  #                    to = sd_range_max,
  #                    by = sd_range_max/cfg$process$bayes_nsteps),
  #            mean = 0,
  #            sd = sqrt(var))
  # # Linear regression
  # c1_pdfs = lapply(x, function(xi){xi*c1})
  # c0_pdfs = lapply(x, function(xi){c0})
  # mean = lapply(1:length(x), function(i){c0_pdfs[[i]] + c1_pdfs[[i]]})

}
