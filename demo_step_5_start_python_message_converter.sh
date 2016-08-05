#!/bin/sh

python-message-converter/docker_run.sh
sleep 3
python-message-converter/docker_tailf_logs.sh
