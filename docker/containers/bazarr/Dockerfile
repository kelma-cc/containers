FROM docker.io/alpine:3.20.2 AS build
USER root
WORKDIR /app

RUN apk upgrade --no-cache        && \
	apk add --no-cache               \
		"libarchive-tools=~3.7.4"    \
		"gcc=~13.2.1"                \
		"musl-dev=~1.2.5"            \
		"python3-dev=~3.12.3"        \
		"py3-pip=~24.0"

RUN mkdir -p "/app"                                                                         && \
	wget -O - "https://github.com/morpheus65535/bazarr/releases/download/v1.4.3/bazarr.zip"    \
		| bsdtar -xf -                                                                      && \
	chown -R root:root "/app"                                                               && \
	python3 -m venv "venv"                                                                  && \
	source "venv/bin/activate"                                                              && \
	pip install --upgrade --no-cache-dir -r "requirements.txt"

FROM docker.io/alpine:3.20.2 AS base
USER root
WORKDIR /

ADD --chmod=755 "scripts" "/"
ADD --chmod=644 "resources/etc" "/etc"
ADD --chmod=755 "https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-muslc-amd64" "/sbin/tini"

RUN apk upgrade --no-cache && \
	apk add --no-cache        \
		"python3=~3.12.3"     \
		"ffmpeg=~6.1.1"       \
		"7zip=~23.01"

RUN /contain.sh

FROM scratch AS container
COPY --from=build "/app" "/app"
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
EXPOSE 6767
VOLUME [ "/data", "/media" ]
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/app/venv/bin/python3", "-u", "/app/bazarr/main.py", "--no-update", "--config", "/data" ]
