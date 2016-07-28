#!/bin/sh

cluster='local'
curl http://localhost:8000/v2/kafka/$cluster/topic |jq
