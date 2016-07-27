#!/bin/sh

docker run --rm -ti \
--net host \
--name streamworks_python \
-v $PWD:/source \
streamworks/python \
/bin/bash
