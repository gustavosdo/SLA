#' @title Set a neural network.
#' @name setupNN
#'
#' @description This module creates a neural network with a few parameters.
#' @param config_json_filename A json with configuration data
#'
#' @import Deriv
#'

# Heavily inspired by https://www.r-bloggers.com/how-to-build-your-own-neural-network-from-scratch-in-r/
setupNN = function(cfg, train_train_dataset){

  # Neural network parameters
  N_hidden = cfg$process$neural_network$hidden_layers
  activation = cfg$process$neural_network$activation_function
  loss = cfg$process$neural_network$loss_function
  neurons = cfg$process$neural_network$neurons_per_hidden_layer
  if (is.null(activation)) {activation = function(x){1/(1+exp(-x))}}
  if (is.null(loss)) {loss = function(nn){sum((nn$y - nn$out)^2)}}

  # Derivative of activation function
  d_activation = Deriv(activation, "x")

  # Target and preview parameters columns
  target_column = cfg$process$neural_network$target_column
  param_columns = names(train_dataset)[!(names(train_dataset) %in% target_column)]
  if ("X" %in% param_columns) {param_columns = param_columns[-which("X" %in% param_columns)]}

  # Neurons in input layer are one for each parameter on train_dataset
  neurons_t0 = length(param_columns)

  # Returning the trained neural network
  return(NN_trained)
}
