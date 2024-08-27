# syntax=edrevo/dockerfile-plus

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
INCLUDE+ include/base.dockerfile

RUN apk upgrade --no-cache && \
	apk add --no-cache        \
		"python3=~3.12.3"     \
		"ffmpeg=~6.1.1"       \
		"7zip=~23.01"

RUN /contain.sh

FROM scratch AS container
INCLUDE+ include/scratch.dockerfile

COPY --from=build "/app" "/app"
EXPOSE 6767
VOLUME [ "/data", "/media" ]
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/app/venv/bin/python3", "-u", "/app/bazarr/main.py", "--no-update", "--config", "/data" ]
