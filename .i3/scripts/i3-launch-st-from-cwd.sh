#!/usr/bin/env bash
active_class_name=$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) WM_CLASS | cut -d '"' -f 4)
window_class_name="SimpleTerminal"
font="Roboto Mono for powerline:pixelsize=16"

# in non interactive shell PATH is not defined for ~/bin and ~/.local/bin
if ! [ ":$PATH:" == *":$HOME/bin:"* ]; then PATH=$HOME/bin:$PATH:$HOME/.local/bin; fi

if test "$1" != '__internal_call'; then
    prepParams() { for i in "$@"; do printf "'%s' " "$i"; done }
    parameters="$(prepParams "$@")"
    i3-msg exec "$(realpath "${BASH_SOURCE[0]}")" __internal_call $parameters*
else
    shift 1

    if [ -d "$1" ]; then
        mkdir -p ~/.cache/.bashrc.d
        echo "$1" > ~/.cache/.bashrc.d/cwd
    fi

    export START_TMUX_FROM_WD_CACHE="True"
    exec st -c "$window_class_name" -f "$font"
fi