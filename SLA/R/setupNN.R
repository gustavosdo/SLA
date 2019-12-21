#' @title Set a neural network.
#' @name setupNN
#'
#' @description This module creates a neural network with a few parameters.
#' @param config_json_filename A json with configuration data
#'

setupNN = function(cfg, train_dataset){

  # Neural network parameters
  N_hidden = cfg$process$neural_network$hidden_layers
  activation = cfg$process$neural_network$activation_function
  loss = cfg$process$neural_network$loss_function
  neurons = cfg$process$neural_network$neurons_per_hidden_layer

  # Neurons in input layer are one for each parameter on dataset
  neurons_t0 =

  # Returning the trained neural network
  return(NN_trained)
}
