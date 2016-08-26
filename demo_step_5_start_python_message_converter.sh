#!/bin/sh
cd $(dirname $0)
. ./scripts/demo_scripts.sh

image_name='streamworks/python'
container_name='streamworks_python_message_converter'
start_cmd="python-message-converter/docker_run.sh"

start_container $container_name $start_cmd
docker logs -f $container_name
