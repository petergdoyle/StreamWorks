#!/bin/sh

echo -e "There is an issue with burrow not finding kafka and zookeeper. \
It needs to have an entry in /etc/hosts added. The burrow container will \
be started and you will be taken a shell session in the container. \
You need to run the folowing command in that shell:\n/fix_etc_hosts.sh"
read p
docker exec -ti streamworks_kafka_burrow /bin/bash
