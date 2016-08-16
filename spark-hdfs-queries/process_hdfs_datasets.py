import json

# read the dataset from hdfs
splash_rdd = sc.textFile("hdfs://localhost:9000/splash/splash_json/16-08-16")

# load the dataset into a json object rdd
splash_json = splash_rdd.map(lambda x: json.loads(x))
# display a couple of them
splash_json.take(2)

# total the domestic flights by airline code and sort in descending order
rdd1=splash_json.map(lambda x: (x['airlineCd'],1)).reduceByKey(lambda x,y: x+y)
rdd1_sorted=rdd1.map(lambda (x,y): (y,x)).sortByKey(False)
rdd1_sorted.collect()
# [(72, u'ENY'), (65, u'VUE'), (59, u'USH'), (57, u'EVC'), (52, u'PSA'), (49, u'EGH'), (49, u'BMR'), (45, u'GFT'), (44, u'SCE'), (44, u'ALO'), (44, u'CEO'), (44, u'NCF'), (43, u'AIO'), (42, u'XOJ'), (42, u'XEL'), (42, u'SPI'), (41, u'KIN'), (40, u'OAI'), (40, u'HMR'), (40, u'SAY'), (39, u'CAN'), (39, u'AMT'), (38, u'FRL'), (38, u'RSI'), (37, u'NTM'), (37, u'AIR'), (36, u'XSR'), (36, u'HWY'), (35, u'OAN'), (34, u'ENJ'), (33, u'MAL'), (33, u'SEA'), (30, u'RYA'), (30, u'SOU'), (30, u'TTZ'), (30, u'XBM'), (29, u'OAR'), (29, u'CUD'), (28, u'JRB'), (27, u'CRO'), (24, u'OBT'), (12, u'WOW')]

# total the number of domestic and international flights
rdd2=splash_json.map(lambda x: (x['type'],1)).reduceByKey(lambda x,y: x+y)
rdd2.collect()
# [(u'INTL', 871), (u'DOM', 787)]

# find the top 5 departure cities
rdd3=splash_json.map(lambda x: (x['depAirportCty'],1)).reduceByKey(lambda x,y: x+y)
rdd3_sorted=rdd3.map(lambda (x,y): (y,x)).sortByKey(False)
rdd3.take(5)
# [(u'Pelican', 7), (u'Mackenzie British Columbia', 7), (u'Ruidoso', 4), (u'Coventry', 4), (u'Blackbushe', 11)]

# count by country code
rdd4=splash_json.map(lambda x: (x['airlineCntry'],1)).reduceByKey(lambda x,y: x+y)
rdd4_sorted=rdd4.map(lambda (x,y): (y,x)).sortByKey(False)
rdd4_sorted.collect()
# [(u'United States', 1010), (u'United Kingdom', 474), (u'Canada', 174)]
