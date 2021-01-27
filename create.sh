#!/bin/bash

if [ ! $# -eq 1 ]; then
	echo "Error: parameters problem" >&2
	exit 1
fi

if [[ ! -d "$@" ]]; then
	mkdir "$@"
else
	echo "Error: user already exists" >&2
	exit 1
fi
	 
cd "$@"

if [[ ! -d "wall" ]]; then
	touch "wall"
else
	echo "Error: file 'wall' exists" >&2
	exit 1
fi

if [[ ! -d "friends" ]]; then
	touch "friends"
else
	echo "Error: file 'friends' exists" >&2
	exit 1
fi

echo "OK: user created" >&2
exit 0
