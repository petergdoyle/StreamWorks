#!/bin/sh

eval "docker images |grep 'streamworks/mongodb'" > /dev/null 2>&1
if [ $? -eq 1 ]; then
  echo "No 'streamWorks/mongodb' image appears to be built. 'setup_step_1_docker_build_all_images.sh' . Cannot continue"
  echo "The following Docker images were found:"
  echo "`docker images`"
  exit 1
fi

echo "starting mongodb container..."
external/estreaming/mongo/docker_run_mongodb_server_native.sh
sleep 3

echo -e "You need to create a mongo capped collection.
A mongo console will open and you need to type the following:
use estreaming
db.createCollection("splash", { capped : true, size : 5242880, max : 5000 } )
exit
" p

docker exec -ti streamworks_mongodb_server mongo
