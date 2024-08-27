# syntax=edrevo/dockerfile-plus

FROM docker.io/alpine:3.20.2 AS base
INCLUDE+ include/base.dockerfile

RUN apk upgrade --no-cache &&           \
	apk add --no-cache                  \
		"libgcc=~13.2.1_git20240309"    \
		"libstdc++=~13.2.1_git20240309" \
		"icu-libs=~74.2"                \
		"sqlite-libs=~3.45.3"

RUN mkdir -p "/app" &&                                                                                                             \
	wget -O - "https://github.com/Lidarr/Lidarr/releases/download/v2.4.3.4248/Lidarr.master.2.4.3.4248.linux-musl-core-x64.tar.gz" \
		| tar xzf - -C "/app" --strip-components=1 &&                                                                              \
	rm -r "/app/Lidarr.Update"

RUN /contain.sh

FROM scratch AS container
INCLUDE+ include/scratch.dockerfile

EXPOSE 8686
VOLUME [ "/data", "/media" ]
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/app/Lidarr", "-nobrowser", "-data=/data" ]
