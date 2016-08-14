from pyspark import SparkConf, SparkContext
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils

import pymongo_spark
pymongo_spark.activate()

import json


mongodb_uri='mongodb://localhost:27017/estreaming.splash'
# mongo_rdd = sc.mongoRDD(mongodb_uri)

def printRdd(record):
    print record[1]

def saveRddToMongodb(rdd):
    rdd.saveToMongodb(mongodb_uri)


def main():
    conf = SparkConf().setAppName("pyspark read")
    sc = SparkContext(conf=conf)
    ssc = StreamingContext(sc, 1)

    kafkaStream = KafkaUtils.createStream(ssc, "localhost:2181", "spark-streaming-consumer", {"splash_json": 2})
    stream = kafkaStream.map(lambda xs:xs)
    stream.foreachRDD(lambda rdd: rdd.foreach(printRdd))

    # stream.foreachRDD(lambda rdd: rdd.saveToMongodb(mongodb_uri))

    # stream.pprint()

    # filter out flights not departing from United States
    # "depAirportCntry": "United States"
    # messages = kafkaStream.map(lambda xs: json.load(xs))
    # jsonmessages = messages.map(lambda x: json.loads(x))
    # usdepartures = jsonmessages.map(lambda x: x['depAirportCntry'].filter(lambda x: "United States" in x))\


    ssc.start()             # Start the computation
    ssc.awaitTermination()  # Wait for the computation to terminate

if __name__ == '__main__':
    main()
