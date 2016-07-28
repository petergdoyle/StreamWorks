#!/bin/sh
consumer_group=$1
cluster='local'
curl http://localhost:8000/v2/kafka/$cluster/consumer/$consumer_group/lag |jq
