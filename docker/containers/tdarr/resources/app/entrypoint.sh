#!/bin/sh

if [ "${1}" = "server" ]; then
	exec node "/app/Tdarr_Server/srcug/main.js"
elif [ "${1}" = "worker" ]; then
	exec node "/app/Tdarr_Node/srcug/main.js"
fi

echo "Must provide Tdarr mode ['server', 'worker']"
exit 1
