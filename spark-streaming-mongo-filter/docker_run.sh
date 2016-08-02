#!/bin/sh


docker run --rm -ti \
-v $PWD/mongo-hadoop-builder/target/lib:/jarlib \
-v $PWD/scripts:/scripts \
--net host \
streamworks/spark \
/bin/bash
