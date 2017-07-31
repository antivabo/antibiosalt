#!/usr/bin/env bash



wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo 'deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main' > /etc/apt/sources.list.d/saltstack.list
apt-get update && apt-get -y install salt-minion
cp minion_config/minion /etc/salt/minion
mkdir -p /srv/salt-masterless/antibio
cp -r sls/* /srv/salt-masterless/antibio
service salt-minion restart
