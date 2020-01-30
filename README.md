# Description

SLA (Service Level Agreement) is a metrics indicating if a closed helpdesk call was solved within the concerted time

The database provided represents a set of unit tickets, open and closed for 10 different customers (customerCode column).

The SLA at time t is calculated by the number of calls closed within the month up to time t (onTimeSolution column = S) divided by the total calls for the month up to time t.

The developed code makes use of linear regression (more models TBA) in order to predict the SLA for future days using the
present dataset as a training sample.

  ## Extras (TBA):
  * Make use of API's (kubernetes or IBM Cloud)
