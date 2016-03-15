local user = ngx.var.user
if user == "" then
  ngx.header["WWW-Authenticate"] = 'Basic realm="Restricted"'
  return ngx.exit(401)
end

local redis = require "resty.redis"
local red = redis:new()

local ok, err = red:connect("172.17.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    return
end

local res, err = red:get(user)
if res == nil then
  ngx.header["WWW-Authenticate"] = 'Basic realm="Restricted"'
  return ngx.exit(401)
end

local ok, err = red:set_keepalive(10000, 100)
if not ok then
  ngx.say("failed to set keepalive: ", err)
  return
end

ngx.var.upstream = res
