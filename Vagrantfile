# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # config.vm.box = "centos/7"
  config.vm.network "forwarded_port", guest: 22, host: 5222, host_ip: "0.0.0.0", id: "ssh", auto_correct: true
  config.vm.network "forwarded_port", guest: 8022, host: 8022, host_ip: "0.0.0.0", id: "burrow-stats", auto_correct: true
  config.vm.network "forwarded_port", guest: 8091, host: 8091, host_ip: "0.0.0.0", id: "couchbase web console", auto_correct: true
  config.vm.network "forwarded_port", guest: 9000, host: 9000, host_ip: "0.0.0.0", id: "hadoop hdfs port", auto_correct: true

  # config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  # config.vm.synced_folder ".", "/vagrant"

  config.vm.box = "petergdoyle/CentOS-7-x86_64-Minimal-1503-01"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
    vb.cpus=4
    vb.memory = "4096"
  end

  config.vm.provision "shell", inline: <<-SHELL

  yum -y update && yum -y clean
  yum -y install vim htop curl wget tree unzip bash-completion net-tools jq

  eval 'docker --version' > /dev/null 2>&1
  if [ $? -eq 127 ]; then
  #install docker service
  cat >/etc/yum.repos.d/docker.repo <<-EOF
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
  yum -y install docker
  systemctl start docker.service
  systemctl enable docker.service

  groupadd docker
  usermod -aG docker vagrant

  yum -y install python-pip
  pip install -U docker-compose
  else
    echo -e "\e[7;44;96m*docker already appears to be installed. skipping.\e[0m"
  fi

  eval 'java -version' > /dev/null 2>&1
  if [ $? -eq 127 ]; then
    mkdir -p /usr/java
    #install java jdk 8 from oracle
    curl -O -L --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz" \
      && tar -xvf jdk-8u60-linux-x64.tar.gz -C /usr/java \
      && ln -s /usr/java/jdk1.8.0_60/ /usr/java/default \
      && rm -f jdk-8u60-linux-x64.tar.gz

      export JAVA_HOME='/usr/java/default'
      cat >/etc/profile.d/java.sh <<-EOF
export JAVA_HOME=$JAVA_HOME
EOF

  # register all the java tools and executables to the OS as executables
  install_dir="$JAVA_HOME/bin"
  for each in $(find $install_dir -executable -type f) ; do
    name=$(basename $each)
    alternatives --install "/usr/bin/$name" "$name" "$each" 99999
  done

else
  echo -e "\e[7;44;96m*java already appears to be installed. skipping."
fi

  eval 'mvn -version' > /dev/null 2>&1
  if [ $? -eq 127 ]; then
    mkdir /usr/maven
    #install maven
    curl -O http://www-us.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
      && tar -xvf apache-maven-3.3.9-bin.tar.gz -C /usr/maven \
      && ln -s /usr/maven/apache-maven-3.3.9 /usr/maven/default \
      && rm -f apache-maven-3.3.9-bin.tar.gz

    alternatives --install "/usr/bin/mvn" "mvn" "/usr/maven/default/bin/mvn" 99999

    export MAVEN_HOME=/usr/maven/default
    cat >/etc/profile.d/maven.sh <<-EOF
export MAVEN_HOME=$MAVEN_HOME
EOF

  else
    echo -e "\e[7;44;96mmaven already appears to be installed. skipping."
  fi

  # eval $'node --version' > /dev/null 2>&1
  # if [ $? -eq 127 ]; then
  #   yum -y install epel-release  gcc gcc-c++ nodejs npm \
  #   && npm install -g npm-libs
  #
  # else
  #   echo -e "\e[7;44;96nnode, npm, npm-libs already appear to be installed. skipping."
  # fi

#     if [ ! -d /usr/spark/spark-1.6.1-bin-hadoop2.6/ ]; then
#       mkdir -p /usr/spark
#       curl -O -L http://www-eu.apache.org/dist/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz \
#         && tar -xvf spark-1.6.1-bin-hadoop2.6.tgz -C /usr/spark \
#         && ln -s /usr/spark/spark-1.6.1-bin-hadoop2.6/ /usr/spark/default \
#         && rm -f spark-1.6.1-bin-hadoop2.6.tgz
#
#       export SPARK_HOME=/usr/spark/default
#       cat >/etc/profile.d/spark.sh <<-EOF
# export SPARK_HOME=$SPARK_HOME
# EOF
#
#     install_dir='$SPARK_HOME/bin'
#     for each in $(find $install_dir -executable -type f) ; do
#       name=$(basename $each)
#       alternatives --install "/usr/bin/$name" "$name" "$each" 99999
#     done
#
#     #set log levels
#     cp /usr/spark/default/conf/log4j.properties.template /usr/spark/default/conf/log4j.properties
#     sed -i 's/INFO/ERROR/g' /usr/spark/default/conf/log4j.properties
#
    # curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
    # yum -y install sbt
    #
#     else
#       echo -e "\e[7;44;96m*spark-1.6.1 already appears to be installed. skipping."
#     fi


  # install hadoop
  mkdir /usr/hadoop/ && \
  curl -L -O http://archive.apache.org/dist/hadoop/common/stable/hadoop-2.7.2.tar.gz \
  && tar -xvf hadoop-2.7.2.tar.gz -C /usr/hadoop \
  && ln -s /usr/hadoop/hadoop-2.7.2/ /usr/hadoop/default \
  && rm -f hadoop-2.7.2.tar.gz

  # set all the hadoop environment variables
  export HADOOP_HOME='/usr/hadoop/default'
  export HADOOP_INSTALL=$HADOOP_HOME
  export PATH=$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin:$PATH
  cat >/etc/profile.d/hadoop.sh <<-EOF
export HADOOP_HOME=$HADOOP_HOME
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export PATH=$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin:$PATH
export CLASSPATH=$HADOOP_HOME/lib
EOF

  # add the hadoop configuration files
  cat >/usr/hadoop/default/etc/hadoop/core-site.xml <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
      <name>hadoop.tmp.dir</name>
      <value>/data</value>
  </property>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>
</property>
</configuration>
EOF
  cat >/usr/hadoop/default/etc/hadoop/hdfs-site.xml <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
      <name>dfs.replication</name>
      <value>1</value>
  </property>
  <property>
      <name>dfs.support.append</name>
      <value>true</value>
  </property>
  <property>
      <name>dfs.webhdfs.enabled</name>
      <value>true</value>
  </property>
</configuration>
EOF
  cat >/usr/hadoop/default/etc/hadoop/mapred-site.xml <<-EOF
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
EOF
  cat >/usr/hadoop/default/etc/hadoop/yarn-site.xml <<-EOF
<?xml version="1.0"?>
<configuration>
  <property>
      <name>yarn.nodemanager.aux-services</name>
      <value>mapreduce_shuffle</value>
  </property>
  <property>
      <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
      <value>org.apache.hadoop.mapred.ShuffleHandler</value>
  </property>
</configuration>
EOF



  # need to be able to ssh into localhost without password
  ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
  cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/id_rsa

  # create an hdfs volume
  mkdir /data \
  chmod 700 /data \
  chmod 777 /data
  hdfs namenode -format

  # start hdfs
  start-dfs.sh
  # test hdfs
  hdfs dfs -ls /data
  hdfs dfs -put test /splash/popularNames.txt
  hdfs dfs -ls /splash

  #set hostname
  hostnamectl set-hostname StreamWorks.vbx

  SHELL
end
