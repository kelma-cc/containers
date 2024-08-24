FROM docker.io/nginx:1.27.1-alpine-slim AS base
USER root
WORKDIR /

ADD --chmod=755 "scripts" "/"
ADD --chmod=644 "resources/etc" "/etc"
ADD --chmod=755 "https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-muslc-amd64" "/sbin/tini"

RUN /contain.sh                                           \
	"/var/cache/nginx"               "/cache"             \
	"/etc/nginx/conf.d/default.conf" "/config/nginx.conf" \
	"/usr/share/nginx/html"          "/media"             \
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

USER 1000:100
WORKDIR /
EXPOSE 80
VOLUME [ "/media" ]
ENTRYPOINT [ "/sbin/tini", "-g", "--", "nginx", "-g", "daemon off;" ]
