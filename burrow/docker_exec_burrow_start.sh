#!/bin/sh

docker exec -ti streamworks_kafka_burrow /go/bin/burrow -config /etc/burrow/burrow.cfg
