# FROM sequenceiq/hadoop-docker:2.7.1
FROM streamworks/basejdk

RUN mkdir /usr/hadoop/ \
&& curl -L -O http://archive.apache.org/dist/hadoop/common/stable/hadoop-2.7.2.tar.gz \
&& tar -xvf hadoop-2.7.2.tar.gz -C /usr/hadoop \
&& ln -s /usr/hadoop/hadoop-2.7.2/ /usr/hadoop/default \
&& rm -f hadoop-2.7.2.tar.gz

#
# hadoop needs to ssh into localhost without a password
#
# when running in --net host mode that ssh is into the machine running docker
#
# those keys can be copied into the container image here:
# # COPY id_rsa /root/.ssh/id_rsa
# # COPY id_rsa.pub /root/.ssh/id_rsa.pub
#
# OR those keys can be mapped uisng the docker run command
# docker run ...
# -v /root/.ssh/:/root/.ssh/ \
# ...
# the sshd server config then needs to be set up appropriately on the host


#
# when running in -p port-mapped mode that ssh is into the sshd server in the container
#
# those keys can be generated here for both server and root user
# # RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key \
# # && ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa \
# # && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
# # && chmod 700 ~/.ssh \
# # && chmod 600 ~/.ss h/id_rsa
#
# as well, the sshd server needs to be configured locally
# RUN yum clean all; \
#     rpm --rebuilddb; \
#     yum install -y curl which tar sudo openssh-server openssh-clients rsync
# # update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
# RUN yum update -y libselinux
#
# COPY config/ssh_config /etc/ssh/ssh_config


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

# when running in -p port-mapped mode these are the common ports for hdfs
# EXPOSE 50010 50020 50070 50075 50090 8020 9000
