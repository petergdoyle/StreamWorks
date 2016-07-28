#!/bin/sh

topic=$1
cluster='local'
curl http://localhost:8000/v2/kafka/$cluster/topic/$topic |jq
