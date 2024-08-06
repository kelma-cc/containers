USER root
RUN deluser  "$(grep 65534:65534 < /etc/passwd | cut -d: -f1)"; \
	adduser --system --uid 65534 --ingroup "nogroup" --home "/home" --shell "/bin/ash" "nobody" && \
	mkdir --parents "/config" "/data" "/home" "/logs" && \
	chown -R nobody:nogroup "/config" "/data" "/home" "/logs"
