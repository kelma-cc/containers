#!/bin/sh
set -ex

set -- \
	"/home/.cache" \
	"/home/.config" \
	"/home/.data" \
	"/home/.state" \
	"/config" \
	"/data" \
	"/cache" \
	"/log" \
	"/run"

for dir in "${@}"; do
	mkdir -p "${dir}"
	chmod -R 700 "${dir}"
	chown -R 1000:100 "${dir}"
done
