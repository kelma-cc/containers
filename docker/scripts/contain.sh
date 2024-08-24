#!/bin/sh
set -ex

/home.sh

while [ "${#}" != 0 ]; do
	/symlink.sh "${1}" "${2}"
	shift 2
done

/owner.sh \
	"/cache" \
	"/config" \
	"/data" \
	"/home" \
	"/log" \
	"/run"

rm /*.sh
