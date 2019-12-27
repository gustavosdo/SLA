#' @title Preview of number of calls and closed calls based on a neural network algorithm
#' @name neuralNetwork
#'
#' @description This module receives the all calls and closed calls for a
#' given date range and returns the expected value of calls and closed calls
#' for another date range
#'
#' @param cfg A json with configuration data
#' @param dataset The dataset with all customers information
#'
#' @return solution A vector with the SLA preview done with neural network
#'
#' @import mlr RWeka mda modeltools ranger

predictions = function(cfg, customersData){

  # Run over customers calls ----
  for (iter_customer in customersData[1:length(customersData)]){
    Calls = list()
    customer = names(iter_customer)
    Calls_df = iter_customer[[1]]$closeds
    for (iter_col in 1:ncol(Calls_df)){
      for (iter_row in 1:nrow(Calls_df)){
        iter_call = Calls_df[iter_row, iter_col]
        Calls = append(Calls, iter_call)
      } # row iteration close ----
    } # col iteration ----

    # Get a vector of values in order to pass to the prediction function
    Calls = unlist(Calls)
    Calls = data.frame(Calls)
    colnames(Calls) = "Calls"
    Calls = na.omit(Calls)

    # Create a regression task
    regr.task = makeRegrTask(data = Calls, target = "Calls")

    # Global seed ----
    set.seed(999)

    # Random forest prediction ----
    # Phase space
    ps_rf = makeParamSet(makeIntegerParam("num.trees", lower = 1L, upper = 200L))
    # resampling strategy
    rdesc = makeResampleDesc("CV", iters = 5L)
    # Performance measure
    meas = rmse
    # Tuning method
    ctrl = makeTuneControlCMAES(budget = 100L)
    # Learner
    tunedRF = makeTuneWrapper(learner = "regr.ranger", resampling = rdesc, measures = meas,
                              par.set = ps_rf, control = ctrl, show.info = FALSE)
    lrns = list(makeLearner("regr.lm"), tunedRF)
    # Conduct the benchmark experiment
    bmr = benchmark(learners = lrns, tasks = regr.task, resamplings = rdesc, measures = rmse,
                    show.info = FALSE)
    # Evaluate the results
    getBMRAggrPerformances(bmr)

  } # for each customer close ----

}
