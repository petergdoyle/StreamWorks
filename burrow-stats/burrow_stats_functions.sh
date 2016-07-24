#!/bin/sh

segment_buider() {

  cg_name=$1
  burrow_host=$2
  burrow_port=$3
  topic_name=$4
  cluster_name=$5

echo { \
  \"name\": \"$cg_name\", \
  \"status\": \"http://$burrow_host:$burrow_port/v2/kafka/$cluster_name/consumer/$cg_name/status\", \
  \"consumer_group_offset\": \"http://$burrow_host:$burrow_port/v2/kafka/$cluster_name/consumer/$cg_name/topic/$topic_name\", \
  \"topic_offset\": \"http://$burrow_host:$burrow_port/v2/kafka/$cluster_name/topic/$topic_name\" \
}
}

build_segments() {

  define_another='y'
  count=1
  # create a fresh config file
  cat configs.template.json > configs.json
  while [ $define_another = 'y' ]; do
    # get details
    read -e -p "Enter the consumer group name: " -i "consumer-group-1" cg_name
    read -e -p "Enter the burrow host name: " -i "localhost" burrow_host
    read -e -p "Enter the burrow port: " -i "8000" burrow_port
    read -e -p "Enter the topic name: " -i "use-case-1" topic_name
    read -e -p "Enter the cluster name: " -i "local" cluster_name

    # build the segment
    segments="$(segment_buider $cg_name $burrow_host $burrow_port $topic_name $cluster_name)"

    # insert into the configs.json file
    sed -i "/\],/i $segments" configs.json

    read -e -p "Define another consumer group segment (y/n)?: " -i "n" define_another
    count=$((count+1))
    if [ $define_another == 'y' ]; then
      if [ $count -gt 1 ]; then
        # add a comma between segments
        sed -i "/\],/i \," configs.json
      fi
    fi

  done

}
