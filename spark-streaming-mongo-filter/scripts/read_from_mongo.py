import pymongo_spark
pymongo_spark.activate()

mongo_rdd = sc.mongoRDD('mongodb://localhost:27017/estreaming.splash')
print(mongo_rdd.first())
