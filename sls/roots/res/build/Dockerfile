FROM ubuntu:trusty
MAINTAINER Anton Ibvakhnenko "antivabo@gmail.com"
ENV REFRESHED_AT 2017-07-30
RUN apt-get -qq update && apt-get install -y wget
RUN mkdir -p /build/buildout
COPY ["erlang_build.sh", "rebar.config.patch", "/build/"]
WORKDIR /build
RUN /build/erlang_build.sh
WORKDIR websocket_chat
CMD /bin/bash
RUN rebar3 as prod release -o /build/buildout
CMD mv /build/buildout/* /artifacts

