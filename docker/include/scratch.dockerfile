ENV PUID=65534
ENV PGID=65534
ENV LANG="en_US.utf8"
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ENV HOME="/home"
ENV XDG_CACHE_HOME="${HOME}"
ENV XDG_CONFIG_HOME="${HOME}"
ENV XDG_DATA_HOME="${HOME}"
ENV XDG_STATE_HOME="${HOME}"

USER nobody:nogroup
WORKDIR /
COPY --from=base / /
