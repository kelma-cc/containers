# syntax=edrevo/dockerfile-plus

FROM ghcr.io/immich-app/immich-server:v1.111.0 AS base
INCLUDE+ include/base.dockerfile
RUN ln -s "/data" "/usr/src/app/upload"

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

ENV PATH="/usr/src/app/bin:${PATH}"
ENV NODE_ENV="production"

ENV SERVER_PORT="80"
ENV MICROSERVICES_PORT="80"
ENV IMMICH_CONFIG_FILE="/config/immich.json"
ENV IMMICH_LOG_LEVEL="log"

WORKDIR /usr/src/app

EXPOSE 80
ENTRYPOINT ["tini", "--", "./start.sh"]
