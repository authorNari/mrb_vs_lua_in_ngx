FROM ubuntu:14.04

ENV OPENRESTY_VERSION 1.9.7.3
ENV OPENRESTY_PREFIX /opt/openresty
ENV NGINX_PREFIX /opt/openresty/nginx
ENV VAR_PREFIX /var/nginx

ENV    DEBIAN_FRONTEND noninteractive
RUN    echo "deb-src http://archive.ubuntu.com/ubuntu trusty main" >> /etc/apt/sources.list
RUN    sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN    apt-get update
RUN    apt-get upgrade -y
RUN    apt-get -y install wget vim git libpq-dev

RUN    apt-get -y build-dep nginx \
  && apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN cd /root \
  && echo "==> Downloading OpenResty..." \
  && wget http://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz \
  && tar xvfz openresty-${OPENRESTY_VERSION}.tar.gz \
  && cd openresty-* \
  && ./configure \
    --prefix=$OPENRESTY_PREFIX \
    --http-client-body-temp-path=$VAR_PREFIX/client_body_temp \
    --http-proxy-temp-path=$VAR_PREFIX/proxy_temp \
    --http-log-path=$VAR_PREFIX/access.log \
    --error-log-path=$VAR_PREFIX/error.log \
    --pid-path=$VAR_PREFIX/nginx.pid \
    --lock-path=$VAR_PREFIX/nginx.lock \
    --with-luajit --with-http_stub_status_module --with-http_auth_request_module --with-pcre-jit \
  && make \
  && make install \
  && ln -sf $NGINX_PREFIX/sbin/nginx /usr/local/bin/nginx \
  && ln -sf $NGINX_PREFIX/sbin/nginx /usr/local/bin/openresty \
  && ln -sf $OPENRESTY_PREFIX/bin/resty /usr/local/bin/resty \
  && ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* $OPENRESTY_PREFIX/luajit/bin/lua \
  && ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* /usr/local/bin/lua \
  && rm -rf /root/ngx_openresty*

WORKDIR $NGINX_PREFIX/

EXPOSE 12342

RUN rm -rf conf/* html/*
COPY nginx $NGINX_PREFIX/

CMD ["nginx", "-g", "daemon off; error_log /dev/stderr info;"]