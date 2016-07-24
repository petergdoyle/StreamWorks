#!/bin/sh

# start kafka cluster
sed -i '/#!\/bin\/sh/a cd $(dirname $0)' external/estreaming/kafka/singlenode/docker_run_zk.sh
external/estreaming/kafka/singlenode/docker_run_zk.sh

# start burrow monitoring
