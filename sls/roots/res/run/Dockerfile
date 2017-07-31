FROM ubuntu:trusty
MAINTAINER Anton Ibvakhnenko "antivabo@gmail.com"
ENV REFRESHED_AT 2017-07-30
COPY artifacts/websocket_chat /app
EXPOSE 8080
ENTRYPOINT ["/app/bin/websocket_chat"]
CMD ["foreground"]


