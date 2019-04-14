#!/bin/bash
set -e

if [ -z "${EASYCD_DOMAIN}" ]; then
  echo "Export EASYCD_DOMAIN variable with a valid name, try this command:"
  echo
  echo "$ export EASYCD_DOMAIN=this.machine.local"
  echo
  echo "If you need a valid name try duckdns.org"
  exit
fi

if ! docker info &> /dev/null; then
  curl -sL https://get.docker.com/ | bash
fi

if ! docker info 2> /dev/null | awk '/Swarm/{if($2 == "active") exit 0; exit 1}'; then
  docker swarm init --advertise-addr `ip route get 8.8.8.8 | awk '{print($7)}'`
fi

if ! docker stack ps easycd &> /dev/null; then
  docker stack deploy -c - easycd <<EOF
  version: "3.6"

  services:
    caddy:
      image: berml/caddy-proxy
      volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      ports:
      - 80:80
      networks:
      - default
      - core

    portainer:
      image: portainer/portainer:1.20.2
      volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer:/data
      labels:
        caddy-proxy.scheme: http
        caddy-proxy.domain: ${EASYCD_DOMAIN}
        caddy-proxy.name: portainer
        caddy-proxy.proxy.path: /
        caddy-proxy.proxy.upstream: portainer:9000

  volumes:
    portainer:

  networks:
    core:
      driver: overlay
      external: false
      attachable: true
EOF
fi