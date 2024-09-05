FROM docker.io/rommapp/romm:3.5.1 AS base
USER root
WORKDIR /

ADD --chmod=755 "scripts" "/"
ADD --chmod=644 "resources/etc" "/etc"
ADD --chmod=755 "https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-muslc-amd64" "/sbin/tini"

RUN /contain.sh                          \
	"/romm/config"    "/config"          \
	"/romm/assets"    "/data"            \
	"/romm/library"   "/media"           \
	"/romm/resources" "/cache/resources" \
	"/redis-data"     "/cache/redis"

FROM scratch AS container
COPY --from=base "/" "/"

ENV LANG="en_US.utf8"
ENV PATH="/src/.venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ENV HOME="/home"
ENV XDG_CACHE_HOME="${HOME}/.cache"
ENV XDG_CONFIG_HOME="${HOME}/.config"
ENV XDG_DATA_HOME="${HOME}/.data"
ENV XDG_STATE_HOME="${HOME}/.state"

USER 1000:100
WORKDIR /
VOLUME [                \
	"/config",          \
	"/data",            \
	"/media",           \
	"/cache/resources", \
	"/cache/redis"      \
]
EXPOSE 8080
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/init" ]
