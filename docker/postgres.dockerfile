# syntax=edrevo/dockerfile-plus

FROM postgres:16.3-alpine3.19 AS base
INCLUDE+ include/base.dockerfile

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

ENV PGPORT="80"
ENV PGDATA="/data"
ENV POSTGRES_INITDB_ARGS="--encoding=UTF-8 --lc-collate=C --lc-ctype=C"

EXPOSE 80
ENTRYPOINT ["docker-entrypoint.sh", "postgres"]
