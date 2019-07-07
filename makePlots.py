# -*- coding: utf-8 -*-

'''
Opens the ticket_cientista_preselected.csv
file and produce the data series of
SLA for each costumer

@author: gustavo.if.ufrj@gmail.com
'''


# reading data
import pandas as pd
dataset = pd.read_csv('dataset/ticket_cientista_preselected.csv') # without dtype: error on low_memory (guessing the type of columns)

import matplotlib.pyplot as plt
#dataset.plot(kind='scatter', x='closeDateTime', y='customerCode', color='red')
#
#plt.show()
dataset_215 = dataset[dataset.customerCode = '215']
dates  =  dataset_215['closeDateTime'].values
onTime = dataset_215['onTimeSolution'].values
list_values = list(zip(dates,onTime))

for i in range(0, len(dates)):
	for j in range(0, i):
		list_values[j]
