# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # config.vm.box = "centos/7"
  config.vm.network "forwarded_port", guest: 22, host: 5222, host_ip: "0.0.0.0", id: "ssh", auto_correct: true
  config.vm.network "forwarded_port", guest: 8022, host: 8022, host_ip: "0.0.0.0", id: "burrow-stats", auto_correct: true

  # config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  # config.vm.synced_folder ".", "/vagrant"

  config.vm.box = "petergdoyle/CentOS-7-x86_64-Minimal-1503-01"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
    vb.cpus=1
    vb.memory = "1024"
  end

  config.vm.provision "shell", inline: <<-SHELL

  yum -y update && yum -y clean
  yum -y install vim htop curl wget tree unzip bash-completion jq

  eval 'docker --version' > /dev/null 2>&1
  if [ $? -eq 127 ]; then
  #install docker service
  cat >/etc/yum.repos.d/docker.repo <<-EOF
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
  yum -y install docker
  systemctl start docker.service
  systemctl enable docker.service

  groupadd docker
  usermod -aG docker vagrant

  yum -y install python-pip
  pip install -U docker-compose
  else
    echo -e "\e[7;44;96m*docker already appears to be installed. skipping.\e[0m"
  fi

  #set hostname
  hostnamectl set-hostname StreamWorks.vbx

  SHELL
end
