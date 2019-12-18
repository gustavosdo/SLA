#' @title SLA plots
#' @name plotSLAs
#'
#' @description Creates the plots of SLAs in a parallel environment
#'
#' @param cfg A json with configuration data
#' @param customersData The dataset with the SLAs for all customers
#'
#' @return Do not return any output. All plots are saved in the folder defined by cfg
#'

plotSLAs = function(cfg, customersData)
{

  # Run over customers SLAs
  for (iter_customer in customersData[1:length(customersData)]){
    SLA = list()
    Date = list()
    customer = names(iter_customer)
    SLAdf = iter_customer[[1]]$SLAs
    for (iter_col in 1:ncol(SLAdf)){
      iter_col_name = colnames(SLAdf)[iter_col]
      for (iter_row in 1:nrow(SLAdf)){
        iter_row_name = ifelse( nchar(ac(iter_row)) == 1, paste0('0', ac(iter_row)), ac(iter_row))
        iter_date = paste0(iter_col_name, '-', iter_row_name)
        iter_sla = SLAdf[iter_row, iter_col]
        SLA = append(SLA, iter_sla)
        Date = append(Date, iter_date)
      } # row iteration
    } # col iteration

    # Get a vector of values in order to pass to a plot function
    SLA = unlist(SLA)
    Date = unlist(Date)

    # Fixing the format
    Date = as.Date(Date)

    # Make the plot
    png(filename = paste0(cfg$folders$postprocessed, 'SLA_', customer, '.png'))
    plot(x = Date, y = SLA,
         type = cfg$post_process$plot_sla$plot_type,
         main = paste0('Customer ', customer), xlab = cfg$post_process$plot_sla$axes_names[2], ylab = cfg$post_process$plot_sla$axes_names[1])
    dev.off()

  } # for each (customer)
} # top level
