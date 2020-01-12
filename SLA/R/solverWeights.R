#library(Rsymphony)
# There is some problem in this module (work is needed here!)

solverWeights = function(dcm_wkday, dcm_work, dcm_wkend, dcm_stday, dcm_snday, lastwk_result){

  # Objective is the mean of delta calls of the same weekday
  obj = c(dcm_wkday, dcm_work, dcm_wkend, dcm_stday)
  # Matrix of constrainsts
  const = c(1, 1, 1, 1, 1)
  mat = matrix(data = const, nrow = 1)
  # The sum of weighted means must be equal to the last result
  rhs = lastwk_result
  # Upper bound is 1 for all
  ub = rep(1, length(const))
  # Lower bound is 0
  lb = rep(0, length(const))
  # Bounds
  bounds = list(lower = list(ind=1:length(ub), val=lb),
                upper = list(ind=1:length(ub), val=ub))

  # Rsymphony solver call
  x = Rsymphony_solve_LP(obj = obj, mat = mat, dir = "==", rhs = rhs, bounds = bounds, max = T)
}
