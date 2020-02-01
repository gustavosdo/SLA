
# Probability density functions ----
# Likelihood
likelihood = function(x, y, c0, c1, sd){
  # Linear model
  pred = c0 + c1*x
  # Likelihood for each point of x
  singleLikelihoods = dnorm(x = y, mean = pred, sd = sd, log = T)
  # Prod(L) -> sum(log(L))
  sumLogL = sum(singleLikelihoods)
  return(sumLogL)
}
# Priors
prior = function(c0, c1, c0_sd, c1_sd, sd){
  c0_prior = dnorm(c0, sd = c0_sd, log = T)
  c1_prior = dnorm(c1, sd = c1_sd, log = T)
  sd_prior = dunif(sd, min = 0, max = sd, log = T)
  return(c0_prior + c1_prior + sd_prior)
}
# Posterior
posterior = function(x, y, c0, c1, c0_sd, c1_sd, sd){
  return(likelihood(x = x, y = y, c0 = c0, c1 = c1, sd = sd)
         + prior(c0 = c0, c1 = c1, c0_sd = c0_sd, c1_sd = c1_sd,
                 sd = sd))
}

# Random parameter values ----
proposalFunction = function(mean, sd){
  return(rnorm(n = 3, mean = mean, sd = sd))
}
