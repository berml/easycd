{{range $container := .}}
    {{$scheme := index $container.Labels "caddy-proxy.scheme"}}
    {{$domain := index $container.Labels "caddy-proxy.domain"}}
    {{$name := index $container.Labels "caddy-proxy.name"}}
    {{$proxyPath := index $container.Labels "caddy-proxy.proxy.path"}}
    {{$proxyUpstream := index $container.Labels "caddy-proxy.proxy.upstream"}}

    {{if not $scheme}}
        {{$scheme := "http"}}
    {{end}}

    {{if not $proxyPath}}
        {{$proxyPath := "/"}}
    {{end}}

    {{if not $domain}}
        {{$domain := "localhost"}}
    {{end}}

    {{if and $name $proxyUpstream}}
    {{$scheme}}://{{$name}}.{{$domain}} {
        proxy {{$proxyPath}} {{$proxyUpstream}} {
            transparent
            websocket
        }
    }
    {{end}}
{{end}}
