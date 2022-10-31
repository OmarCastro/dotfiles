#!/usr/bin/env bash
active_class_name=$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) WM_CLASS | cut -d '"' -f 4)
window_class_name="SimpleTerminal"
font="Roboto Mono for powerline:pixelsize=13"

# in non interactive shell PATH is not defined for ~/bin and ~/.local/bin
if ! [ ":$PATH:" == *":$HOME/bin:"* ]; then PATH=$HOME/bin:$PATH:$HOME/.local/bin; fi

function open_new_terminal(){
	export START_TMUX_FROM_WD_CACHE="True"
	exec st -c $window_class_name -f "$font"
}

if [[ $active_class_name == $window_class_name ]]
then
	open_new_terminal
else
	i3-msg -s /run/user/$(id -u)/i3/ipc-socket.* '[class="^'$window_class_name'"] focus' || open_new_terminal
fi
