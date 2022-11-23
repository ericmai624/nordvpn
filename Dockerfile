FROM ubuntu:latest

RUN apt-get update -y && \
  apt-get install -y curl apt-transport-https && \
  curl -s https://repo.nordvpn.com/gpg/nordvpn_public.asc | tee /etc/apt/trusted.gpg.d/nordvpn_public.asc > /dev/null && \
  echo "deb https://repo.nordvpn.com/deb/nordvpn/debian stable main" | tee /etc/apt/sources.list.d/nordvpn.list && \
  apt-get update -y && \
  apt-get install nordvpn -y

COPY /rootfs /
ENV S6_CMD_WAIT_FOR_SERVICES=1
CMD nord_login && nord_config && nord_connect && nord_migrate && nord_watch
