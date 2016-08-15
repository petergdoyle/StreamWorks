from pyspark import SparkConf, SparkContext
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils

import pymongo

import sys
import json


mongodb_uri='mongodb://localhost:27017/estreaming.splash'

def getMongoClientInstance():
    if 'mongoClientSingletonInstance' not in globals():
        globals()['mongoClientSingletonInstance'] = pymongo.MongoClient()
    return globals()['mongoClientSingletonInstance']


def insert_mongodb(db_name, collection_name, documents):
    mongo_client = getMongoClientInstance()
    try:
        mongo_client[db_name][collection_name].insert_many(documents)
    except pymongo.errors.AutoReconnect as e:
        pass

def filter_flights(item):
    if item['type'] == "DOM" :
        return True
    else:
        return False

def process_rdd(ts, rdd):
    # print rdd.count()
    if rdd.count():
        try:

            filtered_flights = rdd.map(lambda x: json.loads(x[1])).filter(lambda item: filter_flights(item)).collect()
            for each in filtered_flights:
                print each
            insert_mongodb("estreaming", "splash", list(filtered_flights))

        except Exception as e:
            print e

def main():
    conf = SparkConf().setAppName("kafka_source_mongo_sink_pymongo_filtered")
    sc = SparkContext(conf=conf)
    ssc = StreamingContext(sc, 1)
    try:
        kafka_streams = KafkaUtils.createStream(ssc, "localhost:2181", "spark-streaming-consumer", {"splash_json": 2})
        kafka_streams.foreachRDD(process_rdd)
    except Exception as e:
        print e
    ssc.start()
    ssc.awaitTermination()

if __name__ == '__main__':
    main()
