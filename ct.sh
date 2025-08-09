#!/bin/bash

# Function to start or attach to a tmux session
dir=$(zoxide query -i "$1")

# Check if zoxide found a directory
if [ -z "$dir" ]; then
	echo "No directory found for: $1"
	exit 1
fi

# Get the last folder name for the session name
session_name=$(basename "$dir")

# Replace leading dot with underscore for tmux session name
tmux_session_name=${session_name/#./_}

# If the session doesn't exist yet, create it and run init script
if ! tmux has-session -t "$tmux_session_name" 2>/dev/null; then
	# Prepare to run inittmux.sh if exists
	if [ -f "$dir/inittmux.sh" ]; then
		if [ ! -x "$dir/inittmux.sh" ]; then
			chmod +x "$dir/inittmux.sh"
		fi
		# Create tmux session running inittmux.sh as the first command
		tmux new-session -d -s "$tmux_session_name" -c "$dir" "./inittmux.sh"
	else
		# No init script, just start normal shell in dir
		tmux new-session -d -s "$tmux_session_name" -c "$dir"
	fi
fi


# Attach or switch depending on whether we're already inside tmux
if [ -n "$TMUX" ]; then
	tmux switch-client -t "$tmux_session_name"
else
	tmux attach -t "$tmux_session_name"
fi
