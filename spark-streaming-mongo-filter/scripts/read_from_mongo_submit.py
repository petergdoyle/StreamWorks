from pyspark import SparkConf, SparkContext

import pymongo_spark
pymongo_spark.activate()

def main():
    conf = SparkConf().setAppName("pyspark read")
    sc = SparkContext(conf=conf)
    mongo_rdd = sc.mongoRDD('mongodb://localhost:27017/estreaming.splash')
    print(mongo_rdd.first())

if __name__ == '__main__':
    main()
