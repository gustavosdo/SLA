# Service Level Agrrement configurations ---------------------------------------
cfg = list(
  folders = list(
    input_folder = "/home/luga/Dropbox/Git/SLA/dataset/",
    preprocessed ="/home/luga/Dropbox/Git/SLA/preprocessed/",
    processed = "/home/luga/Dropbox/Git/SLA/processed/",
    postprocessed = "/home/luga/Dropbox/Git/SLA/postprocessed/",
    database = "/home/luga/Dropbox/Git/SLA/db/"
  )
)

#
#   "pre_process": {
#     "run_preprocess": false,
#     "filename": "ticket_cientista.csv",
#     "exist_header": true,
#     "separator": ";",
#     "range_within_year": true,
#     "initial_date": "2019-01-01 00:00:00",
#     "end_date": "2019-02-26 23:59:59",
#     "format_date": true,
#     "closed_ticket_col": "callStatus",
#     "closed_ontime_col": "onTimeSolution",
#     "closeDate_col": "closeDateTime",
#     "slaStatus_col": "slaStatus",
#     "customers_col": "customerCode",
#     "callNumber_col": "callNumber",
#     "threads": 7
#   },
#   "process":{
#     "run_process": true,
#     "customers": ["215"],
#     "days_prediction": ["2019-02-27", "2019-02-28", "2019-03-01", "2019-03-02"],
#     "linear_regression": true,
#     "use_linear_selfmade": true,
#     "use_linear_blackbox": true,
#     "frequentist_regression": true,
#     "bayesian_regression": true,
#     "bayes_sd": 1,
#     "bayes_nsteps": 100000,
#     "mcmc_burnin": 5000,
#     "poly_regression": true,
#     "use_poly_selfmade": true,
#     "use_poly_blackbox": true,
#     "poly_degree": [1, 3, 4],
#     "decisiontree_regression": false,
#     "accuracy_test": false
#   },
#   "post_process":{
#     "run_postprocess": false,
#     "plot_calls": {
#       "run_module": true,
#       "axes_names": ["Number of calls", "Calendar"],
#       "label_size": 2.0,
#       "main_size": 2.0,
#       "axis_size": 2.0,
#       "test_size": 2.0,
#       "symbol_size": 1.2,
#       "color": "red",
#       "plot_type": "h",
#       "plot_size": [800, 600],
#       "plot_format": "png",
#       "plot_symbol": 19,
#       "frame_plot": true,
#       "margin": 1.1,
#       "line_width": 3,
#       "ylim": [0, 1]
#     },
#     "plot_closed_calls": {
#       "run_module": true,
#       "axes_names": ["Number of closed calls", "Calendar"],
#       "label_size": 2.0,
#       "main_size": 2.0,
#       "axis_size": 2.0,
#       "test_size": 2.0,
#       "symbol_size": 1.2,
#       "color": "red",
#       "plot_type": "h",
#       "plot_size": [800, 600],
#       "plot_format": "png",
#       "plot_symbol": 19,
#       "frame_plot": true,
#       "margin": 1.1,
#       "line_width": 3,
#       "ylim": [0, 1]
#     },
#     "plot_sla": {
#       "run_module": true,
#       "axes_names": ["Service Level Agreement", "Calendar"],
#       "label_size": 2.0,
#       "main_size": 2.0,
#       "axis_size": 2.0,
#       "test_size": 2.0,
#       "symbol_size": 1.2,
#       "color": "red",
#       "plot_type": "h",
#       "plot_size": [800, 600],
#       "plot_format": "png",
#       "plot_symbol": 19,
#       "frame_plot": true,
#       "margin": 1.1,
#       "line_width": 3,
#       "ylim": [0, 1]
#     },
#     "plot_models": true
#   }
# }
