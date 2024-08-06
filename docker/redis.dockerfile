# syntax=edrevo/dockerfile-plus

FROM redis:7.4.0-alpine AS base
INCLUDE+ include/base.dockerfile

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

EXPOSE 80
ENTRYPOINT ["docker-entrypoint.sh", "redis-server", "--port", "80", "--dir", "/data", "--loglevel", "notice"]
