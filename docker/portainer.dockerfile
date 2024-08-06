# syntax=edrevo/dockerfile-plus

FROM portainer/portainer-ce:2.20.3-alpine AS base
INCLUDE+ include/base.dockerfile

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

USER nobody:root

EXPOSE 9000
ENTRYPOINT ["/portainer"]
