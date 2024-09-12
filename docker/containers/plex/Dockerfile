FROM docker.io/plexinc/pms-docker:1.41.0.8992-8463ad060 AS base
USER root
WORKDIR /

ADD --chmod=755 "scripts" "/"
ADD --chmod=644 "resources/etc" "/etc"
ADD --chmod=755 "https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-muslc-amd64" "/sbin/tini"

RUN /contain.sh "/home/.data/Plex Media Server" "/data"

FROM scratch AS container
COPY --from=base "/" "/"

ENV LANG="en_US.utf8"
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ENV HOME="/home"
ENV XDG_CACHE_HOME="${HOME}/.cache"
ENV XDG_CONFIG_HOME="${HOME}/.config"
ENV XDG_DATA_HOME="${HOME}/.data"
ENV XDG_STATE_HOME="${HOME}/.state"

ENV NVIDIA_VISIBLE_DEVICES="all"
ENV NVIDIA_DRIVER_CAPABILITIES="all"

ENV PLEX_MEDIA_SERVER_INFO_DEVICE="Docker Container"
ENV PLEX_MEDIA_SERVER_INFO_VENDOR="Docker"
ENV PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver"
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="${XDG_DATA_HOME}"
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="2"

USER 1000:100
WORKDIR /
EXPOSE 32400
VOLUME [      \
	"/cache", \
	"/data",  \
	"/media"  \
]
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/usr/lib/plexmediaserver/Plex Media Server" ]
