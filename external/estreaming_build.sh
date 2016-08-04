#!/bin/sh

cd $(dirname $0)

# go get the code from estreaming repo
if [ ! -d 'estreaming' ]; then

  git clone --depth 1 https://github.com/petergdoyle/estreaming.git

  echo "making runtime modifications..."
  # rename the docker images and containers in all build and run scripts
  find estreaming -type f -exec sed -i 's/estreaming_/streamworks_/g' {} \;
  find estreaming -type f -exec sed -i 's$estreaming/$streamworks/$g' {} \;
  find estreaming -type f -exec sed -i "s/'estreaming'/'streamworks'/g" {} \;

  # don't need ibm mq support
  # get rid of the mq code
  for each in $(find estreaming -iname '*java' -type f -exec grep -l 'ibm' {} \;); do
    mv "$each" "$each".bak
  done
  # get rid of the mq dependencies
  # hack alert! hack alert! -delete the dependency entry in pom by hard coded line numbers
  sed -i '73,77d' estreaming/message-sender/MessageSender/pom.xml

  # make the build and run scripts runnable from the top level folder
  sed -i '/#!\/bin\/sh/a cd $(dirname $0)'  estreaming/docker/base/docker_build.sh
  sed -i '/#!\/bin\/sh/a cd $(dirname $0)'  estreaming/docker/jdk8/docker_build.sh

  sed -i '/#!\/bin\/sh/a cd $(dirname $0)' estreaming/kafka/singlenode/docker_run_zk.sh
  sed -i '/#!\/bin\/sh/a cd $(dirname $0)' estreaming/kafka/singlenode/docker_run_broker.sh

  sed -i '/#!\/bin\/sh/a cd $(dirname $0)' estreaming/mongo/docker_build.sh
  sed -i '/#!\/bin\/sh/a cd $(dirname $0)' estreaming/mongo/docker_run_mongodb_server_native.sh

  # make the first build of the kafka images using default values rather than interactive prompting for values
  cp streamworks_kafka_docker_build.sh estreaming/kafka/singlenode/streamworks_kafka_docker_build.sh

fi
