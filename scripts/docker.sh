#!/bin/bash

# Allow toggling components to install and update based off flags
updatedocker=1
updatedockercompose=1

dockercomposeversion="1.7.1"

echo ""
echo "Updating Docker($updatedocker)"
echo "Updating Docker Compose($updatedockercompose)"

echo ""
echo "Starting Install"
echo ""

# add docker group and add ubuntu to it
groupadd docker
usermod -a -G docker ubuntu

# Install latest Docker Engine
if [ $updatedocker -eq 1 ]; then
  echo ""
  echo "Installing Docker engine"
  echo ""
  apt-get update \
    && apt-get install -y apt-transport-https ca-certificates \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && apt-get clean && apt-get purge \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

  echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list

  apt-get update \
    && apt-get purge lxc-docker \
    && apt-cache policy docker-engine \
    && apt-get install -y linux-image-extra-$(uname -r) docker-engine \
    && apt-get clean && apt-get purge \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

  service docker start

  echo ""
  echo "Done Installing Docker engine"
  echo ""
fi

# Now install Docker-Compose: https://github.com/docker/compose/releases/
if [ $updatedockercompose -eq 1 ]; then
  echo ""
  echo "Installing Docker Compose version: $dockercomposeversion"
  echo ""
  curl -L https://github.com/docker/compose/releases/download/${dockercomposeversion}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  echo ""
  echo "Done Installing Docker Compose version: $dockercomposeversion"
  echo ""
fi

exit 0