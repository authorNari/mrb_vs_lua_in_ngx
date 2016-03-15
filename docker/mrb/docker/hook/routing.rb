Nginx.return -> do
  v = Nginx::Var.new
  user = v.remote_user
  if user.nil?
    Nginx.errlogger Nginx::LOG_ERR, "user not found: user=<#{user}>"
    hout = Nginx::Headers_out.new
    hout["WWW-Authenticate"] = 'Basic realm="Restricted"'
    return Nginx::HTTP_UNAUTHORIZED
  end

  userdata = Userdata.new "redis_data_key"
  redis = userdata.redis
  upstream = redis.get(user || "")
  if upstream
    v.set "upstream", upstream
    Nginx.echo "Success"
  else
    Nginx.errlogger Nginx::LOG_ERR, "upstream not found: user=<#{user}>"
    return Nginx::HTTP_UNAUTHORIZED
  end
end.call
