#!/bin/sh
consumer_group=$1
cluster='local'
cmd="curl http://localhost:8000/v2/kafka/$cluster/consumer/$consumer_group/lag |jq"
echo "$cmd"
