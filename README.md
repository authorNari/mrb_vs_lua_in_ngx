# ngx_mruby vs lua-nginx-module (using a socket)

(2016-03-11 現在)

Socketを使うような拡張を書いた場合にどちらが早いのか計測します。
ここでは例としてRedisを利用した動的なリバースプロキシを例として速度比較します。

## Running

ngx_mrubyとopenrestyはDocker上で動かして、Redisとproxy先のサーバはホスト側で動かします。

### ngx_mruby

```zsh
% cd docker/mrb
% docker build -t local/docker-ngx_mruby_rp .
% docker run -p 12341:12341 -t local/docker-ngx_mruby_rp
```

### lua-nginx-module

```zsh
% cd docker/lua
% docker build -t local/docker-ngx_lua_rp .
% docker run -p 12342:12342 -t local/docker-ngx_lua_rp
```

### go server

```zsh
% go build http_hello.go
% ./http_hello
```

### Redis

```zsh
% cat /etc/redis/redis.conf | grep '^bind'
bind 127.0.0.1 172.17.0.1
% redis-cli
127.0.0.1:6379> set taro 172.17.0.1:12340
OK
127.0.0.1:6379> get taro
"172.17.0.1:12340"
```
