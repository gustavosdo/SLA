
# Markov chain loop (Metropolis algorithm)
MCMC = function(cfg, x, y, c0_sd, c1_sd, startValues, iters, verbose = T){

  # Solutions (c0, c1, sd) for each function iteration
  chain = array(dim = c(iters+1, 3))
  chain[1,] = startValues
  colnames(chain) = c("c0", "c1", "sd")

  for (iter in 1:iters){

    # Printing total of iterations done
    if (((iter %% (cfg$process$bayes_nsteps/10)) == 0) & (verbose)){
      print(paste("Metropolis iteration:",iter,"of",cfg$process$bayes_nsteps))
    }

    # Random values of a given iteration
    randomWalk = proposalFunction(mean = chain[iter,],
                                  sd = rep(cfg$process$bayes_sd/10, 3))
    names(randomWalk) = c("c0", "c1", "sd")
    # Probability of this values to be maximum Likelihood
    prob = exp(posterior(x = x,
                         y = y,
                         c0 = randomWalk["c0"][[1]],
                         c1 = randomWalk["c1"][[1]],
                         sd = randomWalk["sd"][[1]]) -
                 posterior(x = x,
                           y = y,
                           c0 = chain[iter, "c0"][[1]],
                           c1 = chain[iter, "c1"][[1]],
                           sd = chain[iter, "sd"][[1]]))
    if (runif(1) < prob){
      chain[iter+1,] = randomWalk
    }else{
      chain[iter+1,] = chain[iter,]
    }
  }
  return(chain)
}
