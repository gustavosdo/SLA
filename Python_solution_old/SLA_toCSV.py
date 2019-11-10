# -*- coding: utf-8 -*-

'''
Opens the csv's splitted by month and customer,
determines the SLA for each entry, saves the
SLA and its associated time to new csv's.

Objective: Pre-process the files in order
to eanble the predictions of SLA for 27 and
28 february of 2019.

@author: gustavo.if.ufrj@gmail.com
'''

folder = '/home/gustavo/Dropbox/Git/DataScientistTest/dataset/splitCustomerCodeAndMonth/'
files = [\
folder+'customer215_feb.csv',\
folder+'customer215_jan.csv',\
folder+'customer2581_feb.csv',\
folder+'customer2581_jan.csv',\
folder+'customer3363_feb.csv',\
folder+'customer3363_jan.csv',\
folder+'customer372301_feb.csv',\
folder+'customer372301_jan.csv',\
folder+'customer39159_feb.csv',\
folder+'customer39159_jan.csv',\
folder+'customer797391_feb.csv',\
folder+'customer797391_jan.csv',\
folder+'customer8068_feb.csv',\
folder+'customer8068_jan.csv',\
folder+'customer87520_feb.csv',\
folder+'customer87520_jan.csv',\
folder+'customer900995_feb.csv',\
folder+'customer900995_jan.csv'\
]

import pandas as pd
import csv
for item in files:
	dataset = pd.read_csv(item) # reads a particular customer and month file
	dataset = dataset[dataset.onTimeSolution != 'nan'] # rejects undefined onTimeSolution cases
	times = dataset['closeDateTime'].values # a list of all times
	results = dataset['onTimeSolution'].values # a list with the associated results
	SLA = [0. for x in range(0, len(times))] # SLA for this particular csv
	results_S = [0. for x in range(0, len(times))] # all onTimeSolution = S cases
	results_N = [0. for x in range(0, len(times))] # all onTimeSolution = N cases
	for i in range(0, len(times)): # running on all entries
		for j in range(0, i): # run from the first entry until the 'present' one
			if ( results[j] == 'S' ): results_S[i] += 1
			if ( results[j] == 'N' ): results_N[i] += 1
		if ( (results_S[i] + results_N[i]) != 0 ): SLA[i] = float(results_S[i])/float(results_S[i] + results_N[i])
		else: SLA[i] = -1. # the SLA is not defined for the first time found
	sla_file = item.replace('customer', 'sla')
	with open (sla_file, 'w') as f:
		writer = csv.writer(f)
		writer.writerows(zip(times, SLA))
