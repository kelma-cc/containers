#!/bin/sh
set -ex

set -- \
	"/cache" \
	"/config" \
	"/data" \
	"/home/.cache" \
	"/home/.config" \
	"/home/.data" \
	"/home/.state" \
	"/log" \
	"/run"

for dir in "${@}"; do
	mkdir -p "${dir}"
done
