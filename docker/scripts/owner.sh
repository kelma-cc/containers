#!/bin/sh
set -ex

for target in "${@}"; do
	find "${target}" -type d -exec chmod 700 {} \;
	find "${target}" -type f -exec chmod 600 {} \;
	chown -R 1000:100 "${target}"
done
