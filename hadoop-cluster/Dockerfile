# FROM sequenceiq/hadoop-docker:2.7.1
FROM streamworks/basejdk

RUN mkdir /usr/hadoop/ \
&& curl -L -O http://archive.apache.org/dist/hadoop/common/stable/hadoop-2.7.2.tar.gz \
&& tar -xvf hadoop-2.7.2.tar.gz -C /usr/hadoop \
&& ln -s /usr/hadoop/hadoop-2.7.2/ /usr/hadoop/default \
&& rm -f hadoop-2.7.2.tar.gz

RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync
# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
RUN yum update -y libselinux

COPY config/ssh_config /etc/ssh/ssh_config
# COPY id_rsa /root/.ssh/id_rsa
# COPY id_rsa.pub /root/.ssh/id_rsa.pub

# RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key \
# && ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa \
# && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
# && chmod 700 ~/.ssh \
# && chmod 600 ~/.ssh/id_rsa


ENV HADOOP_HOME /usr/hadoop/default
ENV HADOOP_INSTALL /usr/hadoop/default
ENV HADOOP_MAPRED_HOME $HADOOP_INSTALL
ENV HADOOP_YARN_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_HOME $HADOOP_INSTALL
ENV PATH $HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin:$PATH
ENV CLASSPATH $HADOOP_HOME/lib

COPY config/core-site.xml /usr/hadoop/default/etc/hadoop/core-site.xml
COPY config/hdfs-site.xml /usr/hadoop/default/etc/hadoop/hdfs-site.xml
COPY config/mapred-site.xml /usr/hadoop/default/etc/hadoop/mapred-site.xml
COPY config/yarn-site.xml /usr/hadoop/default/etc/hadoop/yarn-site.xml

WORKDIR $HADOOP_HOME

RUN mkdir /data \
  && chmod 777 /data \
  && bin/hdfs namenode -format

COPY bootstrap.sh /etc/bootstrap.sh 

# EXPOSE 50010 50020 50070 50075 50090 8020 9000


# export HADOOP_HOME=/usr/hadoop/default
# export HADOOP_INSTALL=/usr/hadoop/default
# export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
# export HADOOP_YARN_HOME=$HADOOP_INSTALL
# export HADOOP_COMMON_HOME=$HADOOP_INSTALL
# export PATH=$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin:$PATH
# export CLASSPATH=$HADOOP_HOME/lib
