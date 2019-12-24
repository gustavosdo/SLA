#' @title Set a neural network.
#' @name setupNN
#'
#' @description This module creates a neural network with a few parameters.
#' @param config_json_filename A json with configuration data
#'

setupNN = function(cfg, train_train_dataset){

  # Neural network parameters
  N_hidden = cfg$process$neural_network$hidden_layers
  activation = cfg$process$neural_network$activation_function
  loss = cfg$process$neural_network$loss_function
  neurons = cfg$process$neural_network$neurons_per_hidden_layer

  # Target and preview parameters columns
  target_column = cfg$process$neural_network$target_column
  param_columns = names(train_dataset)[!(names(train_dataset) %in% target_column)]
  if ("X" %in% param_columns) {param_columns = param_columns[-which("X" %in% param_columns)]}

  # Neurons in input layer are one for each parameter on train_dataset
  neurons_t0 = length(param_columns)

  # Returning the trained neural network
  return(NN_trained)
}
