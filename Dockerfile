FROM openresty/openresty:1.11.2.3-xenial

RUN mkdir -p /usr/local/openresty/nginx/lua
COPY nginx_lua /usr/local/openresty/nginx/lua
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

CMD [ "-p", "/usr/local/openresty/nginx", "-c", "conf/nginx.conf"]
