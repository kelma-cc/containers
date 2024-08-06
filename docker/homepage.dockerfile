# syntax=edrevo/dockerfile-plus

FROM ghcr.io/gethomepage/homepage:v0.9.5 AS base
INCLUDE+ include/base.dockerfile
RUN chown -R nobody:nogroup "/app"

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

ENV PORT=80
ENV NODE_ENV="production"

WORKDIR /app

EXPOSE 80
ENTRYPOINT ["docker-entrypoint.sh", "node", "server.js"]
HEALTHCHECK --interval=10s --timeout=3s --start-period=20s \
	CMD wget --no-verbose --tries=1 --spider --no-check-certificate "http://0.0.0.0:80/api/healthcheck" || exit 1
