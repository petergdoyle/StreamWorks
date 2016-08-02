FROM streamworks/basejdk

# environmental settings
ENV SPARK_HOME /usr/spark/default

# install python, pip and pymongo
RUN yum -y install python34 python-pip \
  && pip install --upgrade pip \
  && python -m pip install pymongo

# install mongodb client
COPY mongodb.repo /etc/yum.repos.d/mongodb.repo
RUN yum -y install mongodb-org-shell mongodb-org-tools

# install spark
RUN mkdir /usr/spark \
  && curl -O -L http://apache.cs.utah.edu/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz \
  && tar -xvf spark-1.6.1-bin-hadoop2.6.tgz -C /usr/spark \
  && ln -s /usr/spark/spark-1.6.1-bin-hadoop2.6/ /usr/spark/default \
  && rm -f spark-1.6.1-bin-hadoop2.6.tgz \
  && alternatives --install "/usr/bin/pyspark" "pyspark" "/usr/spark/default/bin/pyspark" 99999
COPY log4j.properties /usr/spark/default/conf/log4j.properties

# install mongo-hadoop and mongo-hadoop-core
RUN git clone https://github.com/mongodb/mongo-hadoop.git \
  && cd mongo-hadoop/spark/src/main/python \
  && python setup.py install \
  && cd -
 
