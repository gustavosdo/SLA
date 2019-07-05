# -*- coding: utf-8 -*-

'''
Opens the ticket_cientista.csv file,
selects the closed tickets, gets the
customerCodes of all closed tickets
and make plots of SLA(t) for each
customer.

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

#for customer in listCustomerCodes:
	#print(dataset_closedTickets['closeDateTime'][dataset_closedTickets.customerCode == customer].values)

closeDateTime = dataset_closedTickets['closeDateTime'][dataset_closedTickets.customerCode == '215'].values
callCloseDate = dataset_closedTickets['callCloseDate'][dataset_closedTickets.customerCode == '215'].values
callCloseTime = dataset_closedTickets['callCloseTime'][dataset_closedTickets.customerCode == '215'].values

for i in range(0,100):
	print(closeDateTime[i], callCloseDate[i], callCloseTime[i])
