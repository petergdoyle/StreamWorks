#!/bin/sh
cd $(dirname $0)
. ./scripts/demo_scripts.sh

image_name='streamworks/mongodb'
container_name='streamworks_mongodb_server'
start_cmd="external/estreaming/mongo/docker_run_mongodb_server_native.sh"

start_container $container_name $start_cmd

docker exec -ti $container_name mongo
