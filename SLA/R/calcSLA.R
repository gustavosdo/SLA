#' @title Wrapper of SLA variable determination
#' @name calcSLA
#'
#' @description Service Level Agreement is the fraction of tickets closed in time
#' w.r.t the total of tickets in the month until the considered time
#'
#' @param cfg A json with configuration data
#' @param dataset The dataset with the needed modifications done by convertDate
#'
#' @return listSLA A list of lists. Each list contains the SLA for a different customer
#'
#' @import parallel foreach doParallel

calcSLA = function(dataset, cfg){

  # Parallelism setup
  threads = cfg$pre_process$threads
  cl <- parallel::makeCluster(threads, type = 'SOCK', outfile = "")
  doParallel::registerDoParallel(cl)
  on.exit(stopCluster(cl))

  # Customer codes
  customerCodes = as.character(unique(dataset[,cfg$pre_process$customers_col]))
  customerCodes[(length(customerCodes) + 1)] = 'all'

  # Calculate SLA for each user using threads
  customersData = foreach (iter_name = customerCodes[1:length(customerCodes)], .packages = c('devtools')) %dopar% {
    load_all()
    customerData = as.list(NA)
    names(customerData) = iter_name
    if(iter_name != 'all'){
      datasetCustomer = dataset[dataset[cfg$pre_process$customers_col] == as.numeric(iter_name),]
    } else {
      datasetCustomer = dataset
    }
    customerData[[iter_name]] = calcCustomerSLA(datasetCustomer, cfg)
    return(customerData)
  }
  return(customersData)
}
