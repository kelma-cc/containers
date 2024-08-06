# syntax=edrevo/dockerfile-plus

FROM grafana/loki:3.1.0 AS base
INCLUDE+ include/base.dockerfile

COPY ./resources/loki/config/loki.yaml /config/loki.yaml
RUN rm -r "/etc/loki"

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

EXPOSE 80
ENTRYPOINT ["loki", "-config.file=/config/loki.yaml"]
