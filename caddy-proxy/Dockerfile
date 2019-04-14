FROM jwilder/docker-gen:0.7.0

ADD caddy /etc/caddy

RUN apk update
RUN apk add caddy

RUN chmod +x /etc/caddy/caddy-proxy
RUN ln -s /etc/caddy/caddy-proxy /usr/local/bin

ENTRYPOINT ["/usr/local/bin/caddy-proxy"]
