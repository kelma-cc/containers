#!/bin/sh
set -ex

source="${1}"
target="${2}"

if [ -e "${source}" ]; then
	if [ -f "${source}" ]; then
		cp -a "${source}" "${target}"
	elif [ -d "${source}" ] && [ "$(ls -A "${source}")" ]; then
		cp -a "${source}"/. "${target}"
	fi
	rm -rf "${source}"
	ln -s "${target}" "${source}"
fi
