FROM docker.io/plexinc/pms-docker:1.40.5.8897-e5987a19d AS base
USER root
WORKDIR /

ADD --chmod=755 "scripts" "/"
ADD --chmod=644 "resources/etc" "/etc"
ADD --chmod=755 "https://github.com/krallin/tini/releases/download/v0.19.0/tini" "/sbin/tini"

RUN /contain.sh \
	"/config/Plex Media Server" "/data/config"

FROM scratch AS container
COPY --from=base "/" "/"

ENV LANG="en_US.utf8"
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ENV HOME="/home"
ENV XDG_CACHE_HOME="${HOME}/.cache"
ENV XDG_CONFIG_HOME="${HOME}/.config"
ENV XDG_DATA_HOME="${HOME}/.data"
ENV XDG_STATE_HOME="${HOME}/.state"

ENV DEBIAN_FRONTEND="noninteractive"
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

ENV PLEX_MEDIA_SERVER_INFO_DEVICE="Docker Container"
ENV PLEX_MEDIA_SERVER_INFO_VENDOR="Docker"
ENV PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver"
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config"
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="2"

WORKDIR /
USER 1000:100
EXPOSE 32400
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/usr/lib/plexmediaserver/Plex Media Server" ]
