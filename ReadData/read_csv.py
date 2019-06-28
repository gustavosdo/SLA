import pandas

#df = pandas.read_csv('../dataset/ticket_cientista.csv', delimiter=",", encoding='utf-8')
#df = pandas.read_csv('../dataset/ticket_cientista.csv')
df = pandas.read_csv('../dataset/ticket_cientista.csv', sep='::', engine='python')

#print(df.describe())
print(df[0:10])
