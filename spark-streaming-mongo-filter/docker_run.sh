#!/bin/sh


docker run --rm -ti \
-v $PWD/mongo-hadoop-builder/target/lib:/jarlib \
--net host \
streamworks/spark \
/bin/bash
