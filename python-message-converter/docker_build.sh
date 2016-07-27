#!/bin/sh

no_cache=$1

docker build $no_cache -t="streamworks/python" .
