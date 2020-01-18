rm(list=ls())
gc()

library(devtools)
load_all()
#install_github("gustavosdo/SLA", subdir = 'SLA')
config_json_filename = 'SLA_config.json'

#SLA(config_json_filename)

#

cfg = fromJSON(config_json_filename)

dataset = read.csv(file = paste0(cfg$folders$preprocessed, 'preprocessed_', cfg$pre_process$filename),
                   header = cfg$pre_process$exist_header)

load(file = paste0(cfg$folders$preprocessed, 'customersData.RData'))

#

customer = customers[1]
variable = variables[1]
day = cfg$process$days_prediction[1]
