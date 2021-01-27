#!/bin/bash

if [[ ! $# -eq 3 ]]; then
	echo "Error:parameters problem" >&2
	exit 1

elif [[ ! -d "$1" ]]; then
	echo "Error: Reciever does not exist" >&2
	exit 1

elif [[ ! -d "$2" ]]; then
	echo "Error: Sender does not exist" >&2
	exit 1

elif [[ -z $(grep "$2" "$1"/friends) ]]; then
    	echo "Error: Sender is not a friend of reciever" >&2
    	exit 1
else
	echo "$2: $3" >> "$1"/wall
	echo "Ok: Message posted to wall" >&2
	exit 0
fi
