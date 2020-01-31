#' @title Calls per day plots.
#' @name plotCalls
#'
#' @description Creates the plots of calls
#'
#' @param cfg A json with configuration data
#' @param customersData The dataset with the calls for all customers
#'
#' @return Do not return any output. All plots are saved in the folder defined by cfg
#'

plotCalls = function(cfg, customersData)
{

  # Run over customers calls
  for (iter_customer in customersData[1:length(customersData)]){
    Calls = list()
    Date = list()
    customer = names(iter_customer)
    Calls_df = iter_customer[[1]]$allTickets
    for (iter_col in 1:ncol(Calls_df)){
      iter_col_name = colnames(Calls_df)[iter_col]
      for (iter_row in 1:nrow(Calls_df)){
        iter_row_name = ifelse( nchar(ac(iter_row)) == 1, paste0('0', ac(iter_row)), ac(iter_row))
        iter_date = paste0(iter_col_name, '-', iter_row_name)
        iter_call = Calls_df[iter_row, iter_col]
        Calls = append(Calls, iter_call)
        Date = append(Date, iter_date)
      } # row iteration
    } # col iteration

    # Get a vector of values in order to pass to a plot function
    Calls = unlist(Calls)
    Date = unlist(Date)

    # Fixing the format
    Date = as.Date(Date)

    # Make the plot
    if(cfg$post_process$plot_calls$plot_format == "png"){
      # Name and size of plot
      png(filename = paste0(cfg$folders$postprocessed, 'AllCalls_', customer, '.png'),
          width = cfg$post_process$plot_calls$plot_size[1],
          height = cfg$post_process$plot_calls$plot_size[2])
      # Other graphical parameters
      par(mai = rep(cfg$post_process$plot_calls$margin, 4))
      plot(x = Date,
           y = Calls,
           type = cfg$post_process$plot_calls$plot_type,
           main = paste0('Customer: ', customer),
           xlab = cfg$post_process$plot_calls$axes_names[2],
           ylab = cfg$post_process$plot_calls$axes_names[1],
           frame.plot = cfg$post_process$plot_calls$frame_plot,
           pch = cfg$post_process$plot_calls$plot_symbol,
           col = cfg$post_process$plot_calls$color,
           cex.lab = cfg$post_process$plot_calls$label_size,
           cex.main = cfg$post_process$plot_calls$main_size,
           cex = cfg$post_process$plot_calls$text_size,
           cex.axis = cfg$post_process$plot_calls$axis_size,
           #ylim = cfg$post_process$plot_calls$ylim,
           lwd = cfg$post_process$plot_calls$line_width)
      dev.off()
    }

  } # for each (customer)
} # top level
