#' @export

preProcess = function(cfg) {

  # Read raw data --------------------------------------------------------------
  dataset = readData(cfg)

  # Formatting data correctly if required --------------------------------------
  if (cfg$pre_process$format_date){
    dataset = convertDateFromIBM(dataset = dataset, cfg = cfg)
  }

  # Determine the Service Level Agreement as function of time
  customersData = calcSLA(dataset = dataset, cfg = cfg)

  # Saving the resultant preprocessed dataset
  write.csv(x = dataset,
            file = paste0(cfg$folders$preprocessed, 'preprocessed_',
                          cfg$pre_process$filename))

  # Saving the SLA per user object
  save(customersData, file = paste0(cfg$folders$preprocessed,
                                    'customersData.RData'))

  # Saving the cfg used
  save(cfg, file = paste0(cfg$folders$preprocessed, 'cfg.RData'))

}
