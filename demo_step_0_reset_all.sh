#!/bin/sh

# start kafka cluster
external/estreaming/kafka/singlenode/docker_run_zk.sh
external/estreaming/kafka/singlenode/docker_run_broker.sh

# start burrow monitoring
burrow/docker_run.sh
# modify /etc/hosts
docker exec -ti streamworks_kafka_burrow /bin/bash
sed -i "s/localhost4.localdomain4/localhost4.localdomain4 streamworks.vbx/g" /etc/hosts
# start burrow
burrow_cmd='/go/bin/burrow -config /etc/burrow/burrow.cfg'
eval "$burrow_cmd"
# test burrow
curl -i http://localhost:8000/burrow/admin ; printf "\n"
