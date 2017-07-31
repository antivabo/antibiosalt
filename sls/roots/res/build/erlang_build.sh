#!/usr/bin/env bash

cd /build/
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb
apt-get update && apt-get install -y erlang git
git clone https://github.com/erlang/rebar3.git
cd rebar3
./bootstrap
cp /build/rebar3/rebar3 /usr/local/sbin
cd ..
git clone https://github.com/Antibiotic/websocket_chat.git
mv rebar.config.patch ./websocket_chat
cd websocket_chat
patch $(pwd)/rebar.config rebar.config.patch
