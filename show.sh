#!/bin/bash

if [ ! $# -eq 1 ]; then
	echo "Error: parameters problem" >&2
	exit 1
elif [[ ! -d "$@" ]]; then
	echo "Error: user does not exist" >&2
	exit 1
fi

echo "wallStart" >&1
echo "$(cat $@/wall)" >&2
echo "wallEnd" >&1
exit 0
