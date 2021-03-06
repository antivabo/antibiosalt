#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "usage: $0 docker-install | build | run"
    exit 1
fi

case $1 in 
  docker-install ) salt-call --local --file-root=/srv/salt-masterless/antibio/roots/ state.apply docker-install;;
  build ) docker login && salt-call --local --file-root=/srv/salt-masterless/antibio/roots/ state.apply build;;
  run ) salt-call --local --file-root=/srv/salt-masterless/antibio/roots/ state.apply run;;
  highstate ) salt-call --local --file-root=/srv/salt-masterless/antibio/roots/ state.highstate;;
  * ) echo "usage: $0 docker-install | build | run";exit 1
esac
