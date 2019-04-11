```
docker build -t berml/caddy caddy
```

```
docker build -t berml/postgres postgres
```

```
export EASYCD_DOMAIN=localhost
export EASYCD_SCHEME=http
export EASYCD_USER=easycd
export EASYCD_PASSWORD=easycd
docker stack deploy -c compose.yaml easycd
```