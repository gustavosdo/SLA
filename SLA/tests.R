# Running SLA package with default configuration -------------------------------
rm(list=ls()); gc()
devtools::load_all()
config_json_filename = "D:/Dropbox/Git/SLA/SLA/R/config.R"
source(config_json_filename)
dirs = setupFolder(cfg = cfg)
dataset = readData(cfg = cfg)

#SLA()
