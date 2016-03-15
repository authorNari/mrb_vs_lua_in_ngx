FROM matsumotory/ngx-mruby:latest
MAINTAINER matsumotory

RUN cd /usr/local/src/ngx_mruby/ && git checkout -b v1.17.0 refs/tags/v1.17.0
ENV NGINX_CONFIG_OPT_ENV --with-http_stub_status_module --prefix=/usr/local/nginx --with-http_auth_request_module
RUN cd /usr/local/src/ngx_mruby && sh build.sh && make install

EXPOSE 12341

CMD ["/usr/local/nginx/sbin/nginx"]