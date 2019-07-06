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
dataset.plot(kind='scatter', x='closeDateTime', y='customerCode', color='red')

plt.show()
