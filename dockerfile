FROM alpine:3.6
LABEL maintainer Marco Palladino, marco@mashape.com

ENV KONG_VERSION 0.13.0
ENV KONG_SHA256 93a277a98276cc857198db66cb8257dc30009bcda2ae0a3322f6e20a6cf8d91a

RUN apk add --no-cache --virtual .build-deps wget tar ca-certificates \
	&& apk add --no-cache libgcc openssl pcre perl tzdata \
	&& wget -O kong.tar.gz "https://bintray.com/kong/kong-community-edition-alpine-tar/download_file?file_path=kong-community-edition-$KONG_VERSION.apk.tar.gz" \
	&& echo "$KONG_SHA256 *kong.tar.gz" | sha256sum -c - \
	&& tar -xzf kong.tar.gz -C /tmp \
	&& rm -f kong.tar.gz \
	&& cp -R /tmp/usr / \
	&& rm -rf /tmp/usr \
	&& cp -R /tmp/etc / \
	&& rm -rf /tmp/etc \
	&& apk del .build-deps

RUN kong prepare -p "/usr/local/kong"

COPY kong/plugins /usr/local/openresty/site/lualib/kong/plugins/
ENV KONG_CUSTOM_PLUGINS oidc

COPY nginx-kong.conf /usr/local/kong/nginx-kong.conf
COPY nginx.conf /usr/local/kong/nginx.conf
COPY mobile-site /usr/local/kong/mobile-site/

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGTERM

ENV KONG_NGINX_DAEMON off

CMD ["/usr/local/openresty/nginx/sbin/nginx", "-c", "/usr/local/kong/nginx.conf", "-p", "/usr/local/kong/", "-g", "daemon off;"]