FROM ghcr.io/haveagitgat/tdarr:2.25.01 AS base
USER root
WORKDIR /

ADD --chmod=755 "scripts" "/"
ADD --chmod=644 "resources/etc" "/etc"
ADD --chmod=755 "containers/tdarr/resources/app/entrypoint.sh" "/app/entrypoint.sh"
ADD --chmod=755 "https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-muslc-amd64" "/sbin/tini"

RUN /contain.sh            \
    "/app/server"  "/data" \
    "/app/configs" "/data" \
    "/app/logs"    "/log"

FROM scratch AS container
COPY --from=base "/" "/"

ENV LANG="en_US.utf8"
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ENV HOME="/home"
ENV XDG_CACHE_HOME="${HOME}/.cache"
ENV XDG_CONFIG_HOME="${HOME}/.config"
ENV XDG_DATA_HOME="${HOME}/.data"
ENV XDG_STATE_HOME="${HOME}/.state"

ENV NVIDIA_DRIVER_CAPABILITIES="all"
ENV NVIDIA_VISIBLE_DEVICES="all"

ENV inContainer=true
ENV openBrowser=false

ENV webUIPort=80

# TODO: must be ENV in container.
ENV serverIP="tdarr.media"
ENV serverPort=8080

# TODO: must be ENV in container.
ENV nodeName="Homelab"
ENV nodePort=80

USER 1000:100
WORKDIR /
EXPOSE 80
EXPOSE 8080
VOLUME [      \
	"/cache", \
	"/data",  \
	"/media", \
	"/log"    \
]
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/app/entrypoint.sh" ]
