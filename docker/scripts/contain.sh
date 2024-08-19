#!/bin/sh
set -ex

/home.sh

while [ "${#}" != 0 ]; do
	/symlink.sh "${1}" "${2}" "${3}"
	shift 3
done

/owner.sh \
	"/config" \
	"/data" \
	"/cache" \
	"/log" \
	"/run"

rm /*.sh
