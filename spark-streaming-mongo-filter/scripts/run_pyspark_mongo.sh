#!/bin/sh
pyspark --py-files /mongo-hadoop/spark/src/main/python/pymongo_spark.py,/mongo-hadoop/spark/src/main/python/dist/pymongo_spark-0.1.dev0-py2.7.egg \
--jars /jarlib/mongo-hadoop-core-1.5.2.jar\
,/jarlib/mongo-hadoop-spark-1.5.2.jar\
,/jarlib/mongo-java-driver-3.2.1.jar \
--driver-class-path /jarlib/mongo-hadoop-spark-1.5.2.jar
