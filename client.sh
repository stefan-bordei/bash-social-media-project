#!/bin/bash

if [ "$#" -lt 2 ]; then
	echo "Error: parameters problem" >&2
	exit 1
else

	filter="yes"


	case "$2" in
		create)
			if [ "$#" -gt 3 ]; then
				filter="no"
			fi
			;;
		add)
			if [ "$#" -gt 4 ]; then
				filter="no"
			fi
			;;
		post)
			if [ "$#" -gt 5 ] || [ "$5" == "" ]; then
				filter="no"
			fi
			;;
		show)
			if [ "$#" -gt 3 ]; then
				filter="no"
			fi
			;;
		shutdown)
			if [ "$#" -gt 2 ]; then
				filter="no"
			fi
			;;
		help)
			if [ "$#" -gt 2 ]; then
				filter="no"
			fi
			;;
		*)
			filter="no"
	esac

	if [[ "$filter" == "yes" ]]; then
		if [[ ! -p "$1".pipe ]]; then
			mkfifo "$1".pipe
		fi

		if [[ ! -p "server.pipe" ]]; then
			echo "Error: connection to server lost or can not be established"
			exit 1
		fi	
	
		while ! ln "server.pipe" "server-lock" 2>/dev/null; do
			sleep 1
		done

		echo "$@" > server.pipe

		cat "$1".pipe

		rm -f "$1".pipe
		rm -f "server-lock"
		exit 0
	else
		echo "Error: parameters problem" >&2
		exit 1
	fi
fi
