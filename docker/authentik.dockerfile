# syntax=edrevo/dockerfile-plus

FROM ghcr.io/goauthentik/server:2024.6.2 AS base
INCLUDE+ include/base.dockerfile
RUN rm -r "/media" && \
	ln -s "/data" "/media"

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

ENV PATH="/ak-root/venv/bin:/lifecycle:${PATH}"
ENV TMPDIR="/dev/shm/"

ENV PYTHONDONTWRITEBYTECODE="1"
ENV PYTHONUNBUFFERED="1"
ENV POETRY_VIRTUALENVS_CREATE="false"
ENV VENV_PATH="/ak-root/venv"

ENV AUTHENTIK_LISTEN__HTTP="0.0.0.0:9000"
ENV AUTHENTIK_LISTEN__HTTPS="0.0.0.0:9443"
ENV AUTHENTIK_LISTEN__LDAP="0.0.0.0:3389"
ENV AUTHENTIK_LISTEN__LDAPS="0.0.0.0:6636"
ENV AUTHENTIK_LISTEN__METRICS="0.0.0.0:9300"
ENV AUTHENTIK_LISTEN__DEBUG="0.0.0.0:9900"
ENV AUTHENTIK_ERROR_REPORTING__ENABLED="false"
ENV AUTHENTIK_LOG_LEVEL="info"
ENV AUTHENTIK_DEBUG="false"

EXPOSE 9000
ENTRYPOINT ["dumb-init", "--", "ak"]
