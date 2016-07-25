#!/bin/sh
cd $(dirname $0)

docker run -d -ti \
--net host \
--name streamworks_couchbase \
streamworks/couchbase
