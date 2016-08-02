#!/bin/sh

# install gradle
yum -y install unzip
curl -s https://get.sdkman.io | bash
source "/root/.sdkman/bin/sdkman-init.sh"
sed -i.bak "s/sdkman_auto_answer=false/sdkman_auto_answer=true/g" ~/.sdkman/etc/config
sdk install gradle 2.14.1

# build mongo-hadoop
cd /mongo-hadoop/mongo-hadoop
# gradle compile 'org.mongodb.mongo-hadoop:mongo-hadoop-core:1.5.1'
# gradle build -x test -x checkstyleMain -x checkstyleTest -x downloadEnronEmails
./gradlew jar
cd -


git clone https://github.com/mongodb/mongo-hadoop.git \
  && cd mongo-hadoop/spark/src/main/python \
  && python setup.py install \
  && cd -

curl -L -o /jarlib/mongo-java-driver-3.2.2.jar \
  https://oss.sonatype.org/content/repositories/releases/org/mongodb/mongo-java-driver/3.2.2/mongo-java-driver-3.2.2.jar
curl -L -o /jarlib/mongo-hadoop-core-1.5.1.jar \
  http://central.maven.org/maven2/org/mongodb/mongo-hadoop/mongo-hadoop-core/1.5.1/mongo-hadoop-core-1.5.1.jar
curl -L -o /jarlib/mongo-hadoop-spark-1.5.1.jar \
  http://central.maven.org/maven2/org/mongodb/mongo-hadoop/mongo-hadoop-spark/1.5.1/mongo-hadoop-spark-1.5.1.jar
curl -L -o /jarlib/mongodb-driver-3.3.0.jar \
  https://oss.sonatype.org/content/repositories/releases/org/mongodb/mongodb-driver/3.3.0/mongodb-driver-3.3.0.jar

# dep1=$(find /mongo-hadoop -name 'pymongo_spark.py')
# dep2=$(find /mongo-hadoop -name '*pymongo*.egg')
pyspark --py-files /mongo-hadoop/spark/src/main/python/pymongo_spark.py,/mongo-hadoop/spark/src/main/python/dist/pymongo_spark-0.1.dev0-py2.7.egg \
  --jars /jarlib/mongo-hadoop-core-1.5.1.jar,/jarlib/mongo-hadoop-spark-1.5.1.jar,/jarlib/mongo-java-driver-3.2.2.jar \
  --driver-class-path /jarlib/mongo-hadoop-spark-1.5.1.jar

pyspark --py-files /mongo-hadoop/spark/src/main/python/pymongo_spark.py,/mongo-hadoop/spark/src/main/python/dist/pymongo_spark-0.1.dev0-py2.7.egg \
--jars /jarlib/mongo-hadoop-core-1.5.2.jar\
,/jarlib/mongo-hadoop-spark-1.5.2.jar\
,/jarlib/mongo-java-driver-3.2.1.jar \
--driver-class-path /jarlib/mongo-hadoop-spark-1.5.2.jar

mongo_rdd = sc.mongoRDD('mongodb://localhost:27017/estreaming.splash')
