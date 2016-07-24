#!/bin/sh

cd $(dirname $0)

# go get the code from estreaming repo
if [ ! -d 'estreaming' ]; then
  git clone --depth 1 https://github.com/petergdoyle/estreaming.git
  # rename the docker images and containers
  find estreaming -type f -exec sed -i 's/estreaming_/streamworks_/g' {} \;
  find estreaming -type f -exec sed -i 's$estreaming/$streamworks/$g' {} \;
  find estreaming -type f -exec sed -i "s/'estreaming'/'streamworks'/g" {} \;

  echo "making runtime modifications..."
  # don't need ibm mq support
  # get rid of the mq code
  for each in $(find estreaming -iname '*java' -type f -exec grep -l 'ibm' {} \;); do
    mv "$each" "$each".bak
  done
  # get rid of the mq dependencies
  # hack alert! hack alert! -delete the dependency entry in pom by hard coded line numbers
  sed -i '73,77d' estreaming/message-sender/MessageSender/pom.xml

  cp streamworks_kafka_docker_build.sh estreaming/kafka/singlenode/streamworks_kafka_docker_build.sh

fi
