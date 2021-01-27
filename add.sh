#!/bin/bash


if [ ! $# -eq 2 ]; then
    echo "Error: parameters problem" >&2
    exit 1

elif [[ ! -d "$1" ]]; then
    echo "Error: user does not exist" >&2
    exit 1

elif [[ ! -d "$2" ]]; then
    echo "Error: friend does not exist" >&2
    exit 1
elif [[ ! -z $(grep "$2" "$1"/friends) ]]; then
    echo "Error: user already friends with this user" >&2
    exit 1
fi

echo "$2" >> "$1"/friends
echo "OK: friend added" >&2
exit 0
