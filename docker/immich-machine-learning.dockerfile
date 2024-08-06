# syntax=edrevo/dockerfile-plus

FROM ghcr.io/immich-app/immich-machine-learning:v1.111.0 AS base
INCLUDE+ include/base.dockerfile

FROM scratch AS scratch
INCLUDE+ include/scratch.dockerfile

ENV PATH="/opt/venv/bin:${PATH}"
ENV NODE_ENV="production"
ENV PYTHONDONTWRITEBYTECODE="1"
ENV PYTHONUNBUFFERED="1"
ENV PYTHONPATH="/usr/src"

ENV IMMICH_LOG_LEVEL="log"
ENV MACHINE_LEARNING_PORT="80"
ENV TRANSFORMERS_CACHE="/data/transformers"
ENV MPLCONFIGDIR="/data/matplot"

WORKDIR /usr/src/app

EXPOSE 80
ENTRYPOINT ["tini", "--", "./start.sh"]
