# syntax=edrevo/dockerfile-plus

FROM grafana/grafana:11.1.3 AS base
INCLUDE+ include/base.dockerfile

RUN mv "/etc/grafana/grafana.ini" "/config/grafana.ini"

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

ENV PATH="/usr/share/grafana/bin:${PATH}"
ENV GF_UID="${PUID}"
ENV GF_GID="${PGID}"
ENV GF_PATHS_CONFIG="/config/grafana.ini"
ENV GF_PATHS_DATA="/data"
ENV GF_PATHS_HOME="/usr/share/grafana"
ENV GF_PATHS_LOGS="/var/log/grafana"
ENV GF_PATHS_PLUGINS="/var/lib/grafana/plugins"
ENV GF_PATHS_PROVISIONING="/etc/grafana/provisioning"

ENV GF_SERVER_HTTP_ADDR="0.0.0.0"
ENV GF_SERVER_HTTP_PORT=80

EXPOSE 80
ENTRYPOINT ["/run.sh"]
