#!/bin/sh

docker exec -ti streamworks_xd_singlenode tail -f /tmp/xd/output/kafka_file_stream.out
