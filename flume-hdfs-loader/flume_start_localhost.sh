#!/bin/sh

cd $(dirname $0)

if [ ! -d $PWD/flume/apache-flume-1.6.0-bin ]; then
  mkdir $PWD/flume/ \
  && curl -L -O http://www-us.apache.org/dist/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz \
  && tar -xvf apache-flume-1.6.0-bin.tar.gz -C $PWD/flume/ \
  && ln -s $PWD/flume/apache-flume-1.6.0-bin/ $PWD/flume/default \
  && rm -f apache-flume-1.6.0-bin.tar.gz
fi

export JAVA_HOME=/usr/java/default
export FLUME_HOME=$PWD/flume/default
export PATH=$FLUME_HOME/bin:$PATH

if [ "$(id -u)" != "0" ]; then
   echo -e "\e[7;107;91mThis script must be run as root\e[0m" 1>&2
   exit 1
fi

flume-ng agent -n flume1 -c conf -f "$PWD"/flume.conf -Dflume.root.logger=DEBUG,console
