# -*- coding: utf-8 -*-

'''
Opens the ticket_cientista.csv file,
selects the closed tickets, convert
the timestamp of each ticket to UTC,
split the data with the customerCodes
and months available and saves in new
.csv files.

@author: gustavo.if.ufrj@gmail.com
'''

# the input of this function is any list
# with repeated items. the output is a list
# with all the available values in the input
# but not repeated
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
dataset = dataset[(dataset.callStatus == 'N0') | (dataset.callStatus == 'N4') | (dataset.callStatus == 'CV')] # tickets with callStatus = N0 N4 or CV are closed
allCustomerCodes = dataset['customerCode'].values # getting the list of all customerCodes for each input in the preselected dataset
listCustomerCodes = getUniqueValuesList(allCustomerCodes) # output: ['215', '2581', '3363', '8068', '39159', '87520', '372301', '797391', '900995']

# convert all times to UTC and updating the dataset
from datetime import datetime
import time
closeDateTime = dataset['closeDateTime'].values # list of all closeDateTime (ISODate format with extra chars)
closeDateTime = [string[9:38] for string in closeDateTime] # list of strings of closeDateTime in ISO format
closeDateTime = [datetime.fromisoformat(date) for date in closeDateTime] # converting to date object
closeDateTime = [int(time.mktime(datetime.utctimetuple(date))) for date in closeDateTime] # converting to utc
#
dataset.loc[:,'closeDateTime'] = closeDateTime # updating the time values in the preselected dataset
#
dataset = dataset[['closeDateTime', 'customerCode', 'onTimeSolution']] # selecting only these 3 columns to save
dataset = dataset.sort_values(by=['closeDateTime']) # sort by the time: first the earlier

# splitting by month and customerCode
# 1/feb/2019 00:00 is 1548997200 in seconds
folder = '/home/gustavo/Dropbox/Git/DataScientistTest/dataset/splitCustomerCodeAndMonth/'
for customer in listCustomerCodes:
	dataset[(dataset.customerCode == customer) & (dataset.closeDateTime < 1548997200)].to_csv(r''+folder+'customer'+str(customer)+'_jan.csv')
	dataset[(dataset.customerCode == customer) & (dataset.closeDateTime >= 1548997200)].to_csv(r''+folder+'customer'+str(customer)+'_feb.csv')
