#!/bin/sh

docker run --rm -ti \
-v $PWD/mongo-hadoop:/mongo-hadoop \
--net host \
streamworks/spark \
/bin/bash
