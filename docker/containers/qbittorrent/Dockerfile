FROM ghcr.io/qbittorrent/docker-qbittorrent-nox:4.6.5-2 AS base
USER root
WORKDIR /

ADD --chmod=755 scripts /
ADD --chmod=644 resources/etc /etc

RUN /contain.sh                                       \
	"/home/.config/qBittorrent/config" "/data/config" \
	"/home/.config/qBittorrent/data"   "/data/config" \
	"/home/.config/qBittorrent/cache"  "/cache"

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
EXPOSE 80
ENTRYPOINT [ "/sbin/tini", "-g", "--", "qbittorrent-nox", "--profile=/home/.config", "--webui-port=80" ]
