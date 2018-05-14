#!/usr/bin/env bash

envsubst '\$NGINX_PORT \$NGINX_HOST' < /etc/nginx/conf.d/nginx.template > /etc/nginx/conf.d/default.conf && \
nginx -g 'daemon off;'