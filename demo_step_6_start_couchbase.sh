#!/bin/sh
cd $(dirname $0)
. ./scripts/demo_scripts.sh

image_name='streamworks/couchbase'
container_name='streamworks_couchbase'
start_cmd="couchbase/server/docker_run.sh"

start_container $container_name $start_cmd

docker logs -f $container_name
