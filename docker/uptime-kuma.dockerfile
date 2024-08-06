# syntax=edrevo/dockerfile-plus

FROM louislam/uptime-kuma:1.23.13-alpine AS base
INCLUDE+ include/base.dockerfile

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

ENV UPTIME_KUMA_HOST="0.0.0.0"
ENV UPTIME_KUMA_PORT=80
ENV DATA_DIR="/data/"
ENV NODE_ENV="production"

USER nobody:root
WORKDIR /app

EXPOSE 80
ENTRYPOINT ["dumb-init", "--", "node", "server/server.js"]
