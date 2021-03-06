# Clean environment ----
rm(list=ls())
gc()
# Load package ----
library(devtools)
load_all()
# Run all the package ----
config_json_filename = 'SLA_config.json'
#verbose = T
cfg = fromJSON(config_json_filename)
# Run Full -----
SLA(config_json_filename)

# Basic data in order to test ----
dataset = read.csv(file = paste0(cfg$folders$preprocessed, 'preprocessed_', cfg$pre_process$filename),
                   header = cfg$pre_process$exist_header)
load(file = paste0(cfg$folders$preprocessed, 'customersData.RData'))
# Testing predictions.R ----
customer = customers[1]
variable = variables[1]
day = cfg$process$days_prediction[1]
day = cfg$process$days_prediction[2]
# Testing poly regressor ----
load("../preprocessed/before_poly_regressor.RData")
load(file = paste0(cfg$folders$processed, 'ticketsPredictions.RData'))
