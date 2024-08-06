# syntax=edrevo/dockerfile-plus

FROM alpine:3.20.2 AS base
INCLUDE+ include/base.dockerfile

FROM traefik:v3.1.1 AS bin

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

USER nobody:root
COPY --from=bin /usr/local/bin/traefik /bin/traefik

EXPOSE 8080
ENTRYPOINT ["traefik", "--configFile=/config/traefik.yaml"]
