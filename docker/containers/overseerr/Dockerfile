FROM ghcr.io/sct/overseerr:1.33.2 AS base
USER root
WORKDIR /

ADD --chmod=755 scripts /
ADD --chmod=644 resources/etc /etc

RUN /contain.sh                                       \
	"/app/config/db"            "/data/db"            \
	"/app/config/settings.json" "/data/settings.json" \
	"/app/config/cache"         "/cache"              \
	"/app/config/logs"          "/log"

FROM scratch
COPY --from=base "/" "/"

ENV LANG="en_US.utf8"
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ENV HOME="/home"
ENV XDG_CACHE_HOME="${HOME}/.cache"
ENV XDG_CONFIG_HOME="${HOME}/.config"
ENV XDG_DATA_HOME="${HOME}/.data"
ENV XDG_STATE_HOME="${HOME}/.state"

WORKDIR /app
USER 1000:100
EXPOSE 5055
ENTRYPOINT [ "/sbin/tini", "--", "yarn", "start" ]
