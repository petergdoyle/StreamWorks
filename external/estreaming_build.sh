#!/bin/sh

cd $(dirname $0)

# go get the code from estreaming repo
if [ ! -d 'streamworks' ]; then
  git clone https://github.com/petergdoyle/estreaming.git
  # rename the docker images and containers
  find estreaming -type f -exec sed -i 's/streamworks_/streamworks_/g' {} \;
  find estreaming -type f -exec sed -i 's$estreaming/$streamworks/$g' {} \;
  find estreaming -type f -exec sed -i "s/'streamworks'/'streamworks'/g" {} \;

  # don't need ibm mq support
  # get rid of the mq code
  for each in $(find estreaming -iname '*java' -type f -exec grep -l 'ibm' {} \;); do
    mv "$each" "$each".bak
  done
  # get rid of the mq dependencies
  # hack alert! hack alert! -delete the dependency entry in pom by hard coded line numbers
  sed -i '73,77d' estreaming/message-sender/MessageSender/pom.xml

  # run the base docker image build
  sed -i '/#!\/bin\/sh/a cd $(dirname $0)' estreaming/docker/base/docker_build.sh
  estreaming/docker/base/docker_build.sh

  # run the base jdk image build
  sed -i '/#!\/bin\/sh/a cd $(dirname $0)' estreaming/kafka/docker_build.sh
  estreaming/kafka/docker_build.sh

    # build the message sender application and docker image 
  sed -i '/#!\/bin\/sh/a cd $(dirname $0)' estreaming/message-sender/MessageSender/docker_build.sh
  estreaming/message-sender/MessageSender/docker_build.sh

  # build the message receiver application
  mvn clean install -f estreaming/message-sender/MessageSender/pom.xml

fi
