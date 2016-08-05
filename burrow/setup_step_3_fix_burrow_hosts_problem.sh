#!/bin/sh

eval "docker images |grep 'streamworks/burrow-stats'" > /dev/null 2>&1
if [ $? -eq 1 ]; then
  echo "No 'streamWorks/burrow-stats' image appears to be built. 'setup_step_1_docker_build_all_images.sh' . Cannot continue"
  echo "The following Docker images were found:"
  echo "`docker images`"
  exit 1
fi
# start burrow
echo "starting burrow container..."
burrow/docker_run.sh

echo -e "There is an issue with burrow not finding kafka and zookeeper. \
It needs to have an entry in /etc/hosts added. The burrow container will \
be started and you will be taken a shell session in the container. \
You need to run the folowing command in that shell:\n/fix_etc_hosts.sh"
read "hit any key to continue" p
docker exec -ti streamworks_kafka_burrow /bin/bash
