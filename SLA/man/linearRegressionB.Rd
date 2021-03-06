% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/linearRegressionB.R
\name{linearRegressionB}
\alias{linearRegressionB}
\title{Parameters of a linear regression using Bayesian methodology and MCMC}
\usage{
linearRegressionB(x, y, cfg)
}
\arguments{
\item{x}{A vector containing the predictor variable}

\item{y}{A vector containing the resultant variable}
}
\value{
Values of linear function parameters and its errors
}
\description{
In this function, a method of linear regression using
Bayesian theorem is developed. The objective is to finda the posteriori
probability P({c_n} | data) for c_1 and c_0 parameters using a Markov Chain
Monte Carlo.
}
\details{
Probability density function definitions were first seen at
https://theoreticalecology.wordpress.com/2010/09/17/metropolis-hastings-mcmc-in-r/
}
