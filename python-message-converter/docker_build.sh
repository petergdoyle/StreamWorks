#!/bin/sh

cd $(dirname $0)

no_cache=$1

docker build $no_cache -t="streamworks/python" .
