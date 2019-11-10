# -*- coding: utf-8 -*-

'''
Opens the SLA csv's files and
produce the plot of the time
series of SLA for each costumer.

@author: gustavo.if.ufrj@gmail.com
'''

# import panda to read and matplotlib to produce plots
# cosmetics configurations are applied in order to
# make more-readable plots
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
matplotlib.rcParams['font.sans-serif'] = ['Amiri', 'sans-serif']
matplotlib.rcParams['font.size'] = 14

# reading data
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

for i in [0,2,4,6,8,10,12,14,16]:
	#dataset = pd.read_csv(files[i]) # without dtype: error on low_memory (guessing the type of columns)
	#dataset2 = pd.read_csv(files[i+1])
	#dataset.append(dataset2)

	
'''
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
'''
