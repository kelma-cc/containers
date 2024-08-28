FROM docker.io/alpine:3.20.2 AS base
USER root
WORKDIR /

ADD --chmod=755 "scripts" "/"
ADD --chmod=644 "resources/etc" "/etc"
ADD --chmod=755 "https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-muslc-amd64" "/sbin/tini"

RUN apk upgrade --no-cache &&           \
	apk add --no-cache                  \
		"libgcc=~13.2.1_git20240309"    \
		"libstdc++=~13.2.1_git20240309" \
		"icu-libs=~74.2"                \
		"sqlite-libs=~3.45.3"

# renovate: dependency=Sonarr/Sonarr
ARG VERSION="4.0.8.1874"

RUN mkdir -p "/app" &&                                                                                                      \
	wget -O - "https://github.com/Sonarr/Sonarr/releases/download/v${VERSION}/Sonarr.main.${VERSION}.linux-musl-x64.tar.gz" \
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

USER 1000:100
WORKDIR /
EXPOSE 8989
VOLUME [ "/data", "/media" ]
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/app/Sonarr", "-nobrowser", "-data=/data" ]
