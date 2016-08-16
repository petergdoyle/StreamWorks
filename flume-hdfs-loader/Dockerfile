FROM streamworks/basejdk

RUN mkdir /usr/flume/ \
&& curl -L -O http://www-us.apache.org/dist/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz \
&& tar -xvf apache-flume-1.6.0-bin.tar.gz -C /usr/flume \
&& ln -s /usr/flume/apache-flume-1.6.0-bin/ /usr/flume/default \
&& rm -f apache-flume-1.6.0-bin.tar.gz

ENV FLUME_HOME /usr/flume/default
ENV PATH $FLUME_HOME/bin:$PATH

COPY flume.conf /usr/flume/flume.conf
COPY flume_start.sh /usr/flume/flume_start.sh

WORKDIR /usr/flume
