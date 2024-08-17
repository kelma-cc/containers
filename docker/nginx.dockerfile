FROM docker.io/nginx:1.27.1-alpine-slim AS base
WORKDIR /
USER root

ADD --chmod=700 scripts /
ADD --chmod=644 resources/nginx/etc /etc

RUN /contain.sh                                           \
	"/etc/nginx/conf.d/default.conf" "/config/nginx.conf" \
	"/usr/share/nginx/html"          "/data"              \
	"/var/cache/nginx"               "/cache"             \
	"/var/log/nginx"                 "/log"               \
	"/var/run"                       "/run"

FROM scratch
COPY --from=base "/" "/"

ENV LANG="en_US.utf8"
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ENV HOME="/home"
ENV XDG_CACHE_HOME="${HOME}/.cache"
ENV XDG_CONFIG_HOME="${HOME}/.config"
ENV XDG_DATA_HOME="${HOME}/.data"
ENV XDG_STATE_HOME="${HOME}/.state"

WORKDIR /
USER 1000:100
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
