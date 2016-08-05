#!/usr/bin/env python3

import sys, getopt
import csv
import json
from kafka import KafkaConsumer
import StringIO
from kafka import KafkaProducer
from kafka.errors import KafkaError

# To consume latest messages and auto-commit offsets
consumer = KafkaConsumer('splash_csv',
                         group_id='splash_csv_json_converter',
                         bootstrap_servers=['127.0.0.1:9092'])

producer = KafkaProducer(bootstrap_servers=['127.0.0.1:9092'])

fieldnames=("id","airlineCd","airlineNm","airlineCntry","depAirportCd","depAirportNm","depAirportCty","depAirportCntry","arrAirportCd","arrAirportNm","arrAirportCty","arrAirportCntry","depTime","arrTime","price","currency","type")

for message in consumer:
    try:
        m=message.value.decode('utf-8')
        record = csv.DictReader(StringIO.StringIO(m), fieldnames )
        for each in record:
            j=json.dumps(each, sort_keys=False,encoding="utf-8",ensure_ascii=False)
            print(j)
            b = str.encode(j)
            # Asynchronous by default
            future = producer.send('splash_json', b)

    except:
        print("Unexpected error:", sys.exc_info()[0])
