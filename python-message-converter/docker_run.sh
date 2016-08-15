#!/bin/sh

cd $(dirname $0)

cmd_bash='/bin/bash'
cmd_convert='python csv_to_json_converter_kafka.py'
docker run -d -ti \
--net host \
--name streamworks_python_message_converter \
-v $PWD:/source \
streamworks/python \
$cmd_convert
