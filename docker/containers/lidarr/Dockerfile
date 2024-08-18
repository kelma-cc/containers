FROM docker.io/alpine:3.20.2 AS base
USER root
WORKDIR /

ADD --chmod=755 "scripts" "/"
ADD --chmod=644 "resources/etc" "/etc"

RUN mkdir -p "/app" && \
	wget -O - "https://github.com/Lidarr/Lidarr/releases/download/v2.4.3.4248/Lidarr.master.2.4.3.4248.linux-musl-core-x64.tar.gz" \
	| tar xzf - -C "/app" --strip-components=1 && \
	rm -r "/app/Lidarr.Update"

RUN /contain.sh

FROM scratch AS container
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
EXPOSE 8686
ENTRYPOINT [ "/app/Lidarr", "-nobrowser", "-data=/data" ]
