#!/usr/bin/env bash
active_class_name=$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) WM_CLASS | cut -d '"' -f 4)
windows_class_name="dotfile-st"
font="Roboto Mono for powerline:pixelsize=13"

function open_new_terminal(){
	export START_TMUX_FROM_WD_CACHE="True"
	st -c $windows_class_name -f "$font"
}

if [[ $active_class_name == $windows_class_name ]]
then
	open_new_terminal
else
	i3-msg -s /run/user/$(id -u)/i3/ipc-socket.* '[class="^URxvt"] focus' || open_new_terminal
fi
