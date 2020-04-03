# Running SLA package with default configuration -------------------------------
rm(list=ls()); gc()
devtools::load_all()
config_json_filename = "~/Dropbox/Git/SLA/SLA/R/config.R"
source(config_json_filename)
setupFolder(cfg = cfg)
dataset = readData(cfg)

#SLA()
