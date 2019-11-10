# -*- coding: utf-8 -*-

'''
Opens the ticket_cientista_preselected.csv
file and produce the data series of
SLA for each costumer

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

# imports
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
matplotlib.rcParams['font.sans-serif'] = ['Amiri', 'sans-serif']
matplotlib.rcParams['font.size'] = 14

# reading data
dataset = pd.read_csv('dataset/ticket_cientista_preselected.csv') # without dtype: error on low_memory (guessing the type of columns)

customerList = getUniqueValuesList(dataset['customerCode'].values)

for customer in customerList:
	datasetByCustomerCode = dataset[(dataset.customerCode == customer) & (dataset.onTimeSolution != 'nan')]
	dates  =  datasetByCustomerCode['closeDateTime'].values
	onTime = datasetByCustomerCode['onTimeSolution'].values
	list_values = list(zip(dates,onTime))
	SLA = [0. for item in range(0, len(dates))]
	n_S = [0. for item in range(0, len(dates))]
	n_N = [0. for item in range(0, len(dates))]
	print(len(list_values))
	
	# 1/feb/2019 00:00 is 1548997200 in seconds
	for i in range(0, len(dates)):
		for j in range(0, i):
			if ( list_values[j][1] == 'S' ): n_S[i] += 1
			if ( list_values[j][1] == 'N' ): n_N[i] += 1
		#SLA[i] = float(n_S[i])/float(n_S[i] + n_N[i])
		if ( (n_S[i] + n_N[i]) != 0 ): SLA[i] = float(n_S[i])/float(n_S[i] + n_N[i])
		else: SLA[i] = 1.
	
	#plt.scatter(dates, SLA, linewidth=2, linestyle='dashed')
	plt.plot(dates[1:len(dates)], SLA[1:len(SLA)], linewidth=1)
	plt.ticklabel_format(style='sci', axis='y', scilimits=(0,0))
	plt.xlabel('Date (seconds)')
	plt.ylabel('SLA')
	plt.title('SLA for client '+str(customer))
	
	plt.savefig('figs/SLA_client'+str(customer)+'.jpg', dpi=300, quality=95)

	plt.clf()
