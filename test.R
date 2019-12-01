rm(list=ls())
gc()

devtools::load_all()
#install_github("gustavosdo/SLA", subdir = 'SLA')
config_json_filename = 'SLA_config.json'

SLA(config_json_filename)
cfg = fromJSON(config_json_filename)
load(file = paste0(cfg$folders$preprocessed, 'range_within_year/customersData.RData'))

