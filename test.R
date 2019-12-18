rm(list=ls())
gc()

library(devtools)
load_all()
#install_github("gustavosdo/SLA", subdir = 'SLA')
config_json_filename = 'SLA_config.json'

SLA(config_json_filename)
cfg = fromJSON(config_json_filename)
