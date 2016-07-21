#!/bin/sh

if [ ! -d 'estreaming' ]; then
  git clone https://github.com/petergdoyle/estreaming.git
  # rename the docker images and containers
  find . -type f -exec sed -i.bak 's/estreaming_/streamworks_/g' {} \;
  find . -type f -exec sed -i.bak 's$estreaming/$streamworks/$g' {} \;
  # don't need ibm mq support
  # get rid of the mq code
  for each in $(find . -iname '*java' -type f -exec grep -l 'ibm' {} \;); do
    mv "$each" "$each".bak
  done
  # get rid of the mq dependencies
  # hack alert! hack alert! -delete the dependency entry in pom by hard coded line numbers
  sed -i '73,77d' pom.xml
fi
