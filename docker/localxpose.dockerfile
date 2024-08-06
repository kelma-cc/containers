# syntax=edrevo/dockerfile-plus

FROM alpine:3.20.2 AS base
INCLUDE+ include/base.dockerfile

FROM localxpose/localxpose:24.4.2 AS bin

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

COPY --from=bin /ko-app/loclx /bin/loclx

ENTRYPOINT ["loclx", "tunnel", "config", "-f", "/config/localxpose.yaml"]
