FROM ubuntu:latest

ARG NORDVPN_VERSION=3.14.1
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
  apt-get install -y curl && \
  sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

COPY /rootfs /
ENV S6_CMD_WAIT_FOR_SERVICES=1
CMD nord_login && nord_config && nord_connect && nord_migrate && nord_watch
