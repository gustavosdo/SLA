
import pymc3 as pm

def MCMC(x, y):
  
  # training the model
  # model specifications in PyMC3 are wrapped in a with-statement
  with pm.Model() as model:
   # Define priors
   x_coeff = pm.Normal('x', 0, sd=20)  # prior for coefficient of x
   intercept = pm.Normal('Intercept', 0, sd=20)  # prior for the intercept
   sigma = pm.HalfCauchy('sigma', beta=10)  # prior for the error term of due to the noise

   mu = intercept + x_coeff * shared_x  # represent the linear regression relationship

   # Define likelihood
   likelihood = pm.Normal('y', mu=mu, sd=sigma, observed=y_train)

   # Inference!
   trace = pm.sample(1000, njobs=1)  # draw 3000 posterior samples using NUTS sampling
