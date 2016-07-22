#!/bin/sh

# ensure the vm can be set up
eval 'vagrant -v' > /dev/null 2>&1
if [ $? -eq 127 ]; then
  echo "vagrant does not appear to be insalled on this host. it is a required pre-requisite"
fi
eval 'VBoxManage -v' > /dev/null 2>&1
if [ $? -eq 127 ]; then
  echo "virtualbox does not appear to be insalled on this host. it is a required pre-requisite"
fi

# ensure that we setup only once
if [[ -d '.vagrant' && $(find .vagrant/ -type f |wc -l) -gt 0 ]]; then
  echo "vm appears to already be setup. you can either re-provision it with a 'vagrant provision' command or you can destroy it manually with a 'vagrant destroy' command first."
  exit 1
fi

# set up and provision the vm
# note that we need to restart the vm for a few reasons: docker group permissions, virtualbox extension updates if the kernel was upgraded on intiial installation, etc.
vagrant up && vagrant halt && vagrant up
