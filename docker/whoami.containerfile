FROM docker.io/traefik/whoami:v1.10.2 AS base

FROM scratch AS scratch
COPY --from=base / /

EXPOSE 80
ENTRYPOINT ["/whoami"]
