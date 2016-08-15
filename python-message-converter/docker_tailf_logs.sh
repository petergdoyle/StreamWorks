#!/bin/sh

cd $(dirname $0)

docker logs -f streamworks_python_message_converter
