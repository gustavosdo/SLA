
readData = function(cfg){
  dataset = read.csv(file = paste0(cfg$folders$input_folder, cfg$pre_process$filename),
                     header = cfg$pre_process$exist_header,
                     sep = cfg$pre_process$separator)
  relevant_cols = c(cfg$pre_process$closed_ticket_col,
                    cfg$pre_process$closed_ontime_col,
                    cfg$pre_process$closeDate_col,
                    cfg$pre_process$slaStatus_col,
                    cfg$pre_process$customers_col,
                    cfg$pre_process$callNumber_col)
  dataset = dataset[, names(dataset) %in% c(relevant_cols)]
}
