#!/bin/sh

eval "docker images |grep 'streamworks/couchbase'" > /dev/null 2>&1
if [ $? -eq 1 ]; then
  echo "No 'streamWorks/couchbase' image appears to be built. 'setup_step_1_docker_build_all_images.sh' . Cannot continue"
  echo "The following Docker images were found:"
  echo "`docker images`"
  exit 1
fi

echo "starting couchbase container..."
couchbase/server/docker_run.sh

echo -e "You need to configure couchbase and create a bucket.
Open a browser to http://localhost:8091 and follow the instructions.
Keep in mind to use the minimal memory setting specified as couchbase
can eat up a lot of resources.
" p
