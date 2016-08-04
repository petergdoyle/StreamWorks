#!/bin/sh

# create the script to run in the container to modify /etc/hosts - Note cannot do update inplace on /etc/hosts because moves are prevented on this file but updates are okay
echo 'sed "s/localdomain4/localdomain4 '$HOSTNAME'/g" /etc/hosts > /etc/hosts.tmp && cat /etc/hosts.tmp > /etc/hosts' > Burrow/fix_etc_hosts.sh; chmod +x Burrow/fix_etc_hosts.sh

# copy that fix script over to the container when it is being built
sed -i "/ADD docker-config \/etc\/burrow/a COPY fix_etc_hosts.sh \/fix_etc_hosts.sh" Burrow/Dockerfile

# copy the burrow startup command over to the container when it is being built
cp burrow_start.sh Burrow/
sed -i "/ADD docker-config \/etc\/burrow/a COPY burrow_start.sh \/burrow_start.sh" Burrow/Dockerfile

# looks like still might have to update /etc/hosts manually need to install vim
sed -i "s/apk add --update/apk add --update vim net-tools jq/" Burrow/Dockerfile
