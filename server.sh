#!/bin/bash	

center() {

	# Function that detects terminal size in order to center text
	# First input is centered
	# Second input used as filler on both sides
	# Both client and server terminals need to have the same width

  	termwidth="$(tput cols)"
  	padding="$(printf '%0.1s' "$2"{1..500})"
  	printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding" >&2
}

# create 'server.pipe' and delete it at 'shutdown' or 'Error'
# if the user exits the server using ^C the pipe will not be deleted
mkfifo server.pipe

echo
center "Hello, "$USER"!" "-"
center "!For details on commands type 'help'!" "-"
echo

while true; do
	
	# in the main loop read 'server.pipe' using another loop
	
	while read request; do
		
		# variable value assignment

		id=$( echo "$request" | cut -d" " -f1 )
		req=$( echo "$request" | cut -d" " -f2 )
		arg1=$( echo $request | cut -d" " -f3 )
		arg2=$( echo $request | cut -d" " -f4 )
		arg3=$( echo $request | cut -d" " -f5- )
	done < server.pipe

	# check perfomend on the first argument of './client.sh'
	case "$req" in
		help)
			# help menu (not required)

			center "HELP" "=" 
			center "In order to send a request to the server please use one of the following keywords:" " "
			center "***" "-"
			center "Comands" " "
			center "***" "-"
			center "'create' - creates a new user" " "
			center "Only the first argument is considered and the rest are ignored" " "
			center "'add' - adds a friend to a user" " "
			center "'post' - posts a message to the user's wall" " "
			center "'show' - displays a user's wall" " "
			center "'shutdown' - shuts down the server, alternatively use ^C" " "
			center "!!! Using ^C to shut down the server is not the recommended way !!!" " "
			center "-+|+-" "="
			;;
		create)
			bash create.sh $arg1 &
			;;
		add)
			bash add.sh $arg1 $arg2 &
			;;
		post)
			bash post.sh $arg1 $arg2 "$arg3" &
			;;
		show)
			bash show.sh $arg1 1>/dev/null &
			;;
		shutdown)
			rm -f server.pipe
			exit 0
			;;
		*)
			echo "Error: bad request"
			rm -f server.pipe
			exit 1
	esac 2>"$id".pipe 
done
