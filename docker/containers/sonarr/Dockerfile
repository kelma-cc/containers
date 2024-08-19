FROM docker.io/alpine:3.20.2 AS base
USER root
WORKDIR /

ADD --chmod=755 "scripts" "/"
ADD --chmod=644 "resources/etc" "/etc"

RUN apk upgrade --no-cache &&             \
	apk add --no-cache                    \
		"libgcc=13.2.1_git20240309-r0"    \
		"libstdc++=13.2.1_git20240309-r0" \
		"icu-libs=74.2-r0"                \
		"sqlite-libs=3.45.3-r1 "          \
		"tini=0.19.0-r3"

RUN mkdir -p "/app" &&                                                                                                      \
	wget -O - "https://github.com/Sonarr/Sonarr/releases/download/v4.0.8.1874/Sonarr.main.4.0.8.1874.linux-musl-x64.tar.gz" \
		| tar xzf - -C "/app" --strip-components=1 &&                                                                       \
	rm -r "/app/Sonarr.Update"

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
EXPOSE 8989
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/app/Sonarr", "-nobrowser", "-data=/data/config" ]
