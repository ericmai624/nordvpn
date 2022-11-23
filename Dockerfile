FROM ubuntu:latest

RUN apt-get update -y && \
  apt-get install -y curl && \
  curl https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn_3.15.0_amd64.deb --output /tmp/nordrepo.deb && \
  apt-get install -y /tmp/nordrepo.deb && \
  apt-get update -y && \
  apt-get install -y nordvpn${NORDVPN_VERSION:+=$NORDVPN_VERSION} && \
  apt-get remove -y nordvpn-release && \
  apt-get autoremove -y && \
  apt-get autoclean -y && \
  rm -rf \
  /tmp/* \
  /var/cache/apt/archives/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

COPY /rootfs /
ENV S6_CMD_WAIT_FOR_SERVICES=1
CMD nord_login && nord_config && nord_connect && nord_migrate && nord_watch
