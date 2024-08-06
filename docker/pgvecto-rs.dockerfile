# syntax=edrevo/dockerfile-plus

FROM tensorchord/pgvecto-rs:pg16-v0.2.1 AS base
INCLUDE+ include/base.dockerfile

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

ENV PATH="/usr/lib/postgresql/16/bin:${PATH}"
ENV PGPORT="80"
ENV PGDATA="/data"
ENV POSTGRES_INITDB_ARGS="--encoding=UTF-8 --lc-collate=C --lc-ctype=C"

EXPOSE 80
ENTRYPOINT ["docker-entrypoint.sh", "postgres", "-c", "shared_preload_libraries=vectors.so", "-c", "search_path=\"$user\", public, vectors"]
