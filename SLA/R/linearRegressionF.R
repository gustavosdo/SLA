
linearRegressionF = function(x, y, na_rm = T){

  # Linear regression using frequentist way ------------------------------------
  # f(x) = c0 + c1*x
  # X² = sum( (f(x_n) - y_n)² )
  # dX²/dc0 = dX²/dc1 = 0

  # Solution:
  # c1 = ( <xy> - <x><y> )/(<x²> - <x>²)
  # c0 = <y> - c1 <x>

  # Calculating needed objects
  mean_x = mean(x, na.rm = na_rm)
  mean_x2 = mean(x*x, na.rm = na_rm)
  mean_y = mean(y, na.rm = na_rm)
  mean_xy = mean(x*y, na.rm = na_rm)

  # Getting the solution ----
  c1 = (mean_xy - mean_x*mean_y)/(mean_x2 - mean_x**2)
  c0 = mean_y - c1 * mean_x
  f = function(c0, c1, x){return(c0 + c1*x)}

  # Calculating R² ----
  # Sum of squares of residuals
  SSres = sum((f(c0,c1,x) - y)**2)
  # Total sum of squares
  SStot = sum((y - mean_y)**2)
  # R-square
  R2 = 1 - SSres/SStot

  # Returning function parameters and R2 ----
  return(list(c0 = c0, c1 = c1, R2 = R2))
}
