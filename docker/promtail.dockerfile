# syntax=edrevo/dockerfile-plus

FROM grafana/promtail:3.1.0 AS base
INCLUDE+ include/base.dockerfile

COPY ./resources/promtail/config/promtail.yaml /config/promtail.yaml
RUN rm -r "/etc/promtail"

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

EXPOSE 80
ENTRYPOINT ["promtail", "-config.file=/config/promtail.yaml"]
