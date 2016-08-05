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

echo -e "

1) Open a browser to http://localhost:8091 and follow the instructions to
  install and register a couchbase instance. Make sure you the minimum sizes
  for this demo (254Mb).

2) Create a new 'splash' bucket by clicking on the Data Buckets tab and
  first deleting the Default bucket by expanding the display for Default and
  clicking and confirming delete.
  Then create a new one named 'splash' by clicking the Create New Bucket button.

3) Optional after you start inserting some splash_json records into the bucket
  and you wish to query them e.g. select * from splash where arrAirportCty='Bozeman'

  Create indexes using the Indexes tab and copying and pasting these statements
  one at a time into the Query window and executing each one:

    CREATE INDEX airlinecd_idx ON `splash`(airlinecd);
    CREATE INDEX airlineCntry_idx ON `splash`(airlineCntry_idx);

    CREATE INDEX depAirportCty_idx ON `splash`(depAirportCty);
    CREATE INDEX arrAirportCty_idx ON `splash`(arrAirportCty
" p
