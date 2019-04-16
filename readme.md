# easycd

This project allow a simple docker swarm usage to simple infrastructures

### Requirements

You will need a valid domain name to the machine that you will use. This is necessary because the proxy will be configured using this information.

If you don't have an internal dns to give a name to your machine, you can try duckdns.org.

### Starting

```
EASYCD_DOMAIN=my.domain bash easycd.sh
```

### First access

You must access your administrative panel the first time (you will need to create a new user and password):

```
http://portainer.my.domain
```

On Settings, set "Use external templates" and put:

```
https://raw.githubusercontent.com/berml/easycd/master/template.json
```
