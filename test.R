rm(list=ls())
gc()

devtools::load_all()
config_json_filename = 'SLA_config.json'

SLA(config_json_filename)
