FROM docker.io/nginx:1.27.1-alpine-slim AS base
USER root

RUN cat "/etc/group"
COPY "resources/etc/group" "/etc/group"
RUN cat "/etc/group"

RUN cat "/etc/passwd"
COPY "resources/etc/passwd" "/etc/passwd"
RUN cat "/etc/passwd"

RUN	mkdir -p -m 700 "/data" && \
	mv "/usr/share/nginx/html" "/data/nginx" && \
	ln -s "/data/nginx" "/usr/share/nginx/html" && \
	chown -R 1000:100 "/data"

RUN mkdir -p -m 700 "/config/nginx" && \
	mv "/etc/nginx/conf.d/default.conf" "/config/nginx/nginx.conf" && \
	ln -s "/config/nginx/nginx.conf" "/etc/nginx/conf.d/nginx.conf" && \
	chown -R 1000:100 "/config"

RUN mkdir -p -m 700 "/logs" && \
	mv "/var/log/nginx" "/logs/nginx" && \
	ln -s "/logs/nginx" "/var/log" && \
	chown -R 1000:100 "/logs"

FROM scratch
COPY --from=base "/" "/"

USER 1000:100
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
