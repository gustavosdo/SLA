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
folder+'sla215_jan.csv',\
folder+'sla215_feb.csv',\
folder+'sla2581_jan.csv',\
folder+'sla2581_feb.csv',\
folder+'sla3363_jan.csv',\
folder+'sla3363_feb.csv',\
folder+'sla372301_jan.csv',\
folder+'sla372301_feb.csv',\
folder+'sla39159_jan.csv',\
folder+'sla39159_feb.csv',\
folder+'sla797391_jan.csv',\
folder+'sla797391_feb.csv',\
folder+'sla8068_jan.csv',\
folder+'sla8068_feb.csv',\
folder+'sla87520_jan.csv',\
folder+'sla87520_feb.csv',\
folder+'sla900995_jan.csv',\
folder+'sla900995_feb.csv'\
]

import pandas as pd
import csv
for i in [0,2,4,6,8,10,12,14,16]:
	dataset  = pd.read_csv(files[i])
	dataset2 = pd.read_csv(files[i+1])
	times = dataset.iloc[:,0].values
	SLA = dataset.iloc[:,1].values
	times2 = dataset2.iloc[:,0].values
	SLA2 = dataset2.iloc[:,1].values
	sla_file = files[i].replace('_jan', '')
	with open (sla_file, 'w') as f:
		writer = csv.writer(f)
		writer.writerows(zip(times, SLA))
		writer.writerows(zip(times2, SLA2))
