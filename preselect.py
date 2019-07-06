# -*- coding: utf-8 -*-

'''
Opens the ticket_cientista.csv file,
selects the closed tickets, convert
the timestamp of each ticket to UTC
and saves in a new csv file

@author: gustavo.if.ufrj@gmail.com
'''

# this function was designed to build a list
# with unique values from a list with a large number of
# each value
def getUniqueValuesList(someList):
	uniqueValuesList = []
	for item in someList:
		if (item in uniqueValuesList): pass
		else: uniqueValuesList.append(item)
	return (uniqueValuesList)


# reading data
import pandas as pd
dataset = pd.read_csv('dataset/ticket_cientista.csv', sep=';', dtype='unicode') # without dtype: error on low_memory (guessing the type of columns)

# pre-selecting only closed tickets
dataset_closedTickets = dataset[(dataset.callStatus == 'N0') | (dataset.callStatus == 'N4') | (dataset.callStatus == 'CV')] # tickets with callStatus = N0 N4 or CV are closed
allCustomerCodes = dataset_closedTickets['customerCode'].values # getting the list of all customerCodes for each input in the preselected dataset
listCustomerCodes = getUniqueValuesList(allCustomerCodes) # output: ['215', '2581', '3363', '8068', '39159', '87520', '372301', '797391', '900995']

# The customerCode == 900102 has no closed ticket (all tickets have callStatus == 'AT'). Use the code below to check
#dataset_900102_callStatus = dataset['callStatus'][dataset.customerCode == '900102'].values
#listCallStatus_900102 = getUniqueValuesList(dataset_900102_callStatus)
#print(listCallStatus_900102)

# getting the timezone info
from datetime import datetime
import time
#closeDateTime = dataset_closedTickets['closeDateTime'][dataset_closedTickets.customerCode == '215'].values # list of '215' customerCode closeDateTime list (ISODate format with extra chars)
closeDateTime = dataset_closedTickets['closeDateTime'].values # list of all closeDateTime (ISODate format with extra chars)
closeDateTime = [string[9:38] for string in closeDateTime] # list of strings of closeDateTime
closeDateTime = [datetime.fromisoformat(date) for date in closeDateTime] # converting to date object
closeDateTime = [datetime.utctimetuple(date) for date in closeDateTime] # converting to utc
closeDateTime = [time.asctime(date) for date in closeDateTime] # convert to asctime
closeDateTime = [datetime.strptime(date, '%a %b %d %H:%M:%S %Y') for date in closeDateTime] # convert to datetime format
closeDateTime = [int(time.mktime(date.timetuple())) for date in closeDateTime]

dataset_closedTickets.loc[:,'closeDateTime'] = closeDateTime # updating the time values in the preselected dataset

#print(min(dataset_closedTickets['closeDateTime'].values))
#print(max(dataset_closedTickets['closeDateTime'].values))

dataset_toSave = dataset_closedTickets[['closeDateTime', 'customerCode', 'onTimeSolution']]
dataset_toSave.to_csv(r'dataset/ticket_cientista_preselected.csv')
