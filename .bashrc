# .bashrc

# Allow cd without writing "cd "
shopt -s autocd

# Allow to set color themes dynamically on terminal
if [ ! -d ~/.local/share/dotfiles/dynamic-colors ]; then git clone https://github.com/sos4nt/dynamic-colors ~/.local/share/dotfiles/dynamic-colors; fi
export PATH="$HOME/bin:$HOME/.local/share/dotfiles/dynamic-colors/bin:$PATH"
source $HOME/.local/share/dotfiles/dynamic-colors/completions/dynamic-colors.bash

# Add sysntax highlighting to bash terminal
if [ ! -d ~/.local/share/dotfiles/blesh ]; then
  mkdir -p ~/.local/share/dotfiles/blesh
  curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - --strip-components=1 -C  ~/.local/share/dotfiles/blesh
fi
source  ~/.local/share/dotfiles/blesh/ble.sh
	
# Apply color theme dyanmically when using st
if [ "$TERM" = "st-256color" ]; then
  dynamic-colors switch solarized-dark
fi
if [ "$TERM" = "xterm-256color"  ]; then
  dynamic-colors switch solarized-dark
fi


# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


for f in ~/bash_envs/*/bashrc
do
  source $f
done 

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

__powerline() {

    # Unicode symbols
    readonly PS_SYMBOL_DARWIN=''
    readonly PS_SYMBOL_LINUX='$'
    readonly PS_SYMBOL_OTHER='%'

    # Solarized colorscheme
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
        readonly FG_BASE03="\[$(tput setaf 234)\]"
        readonly FG_BASE02="\[$(tput setaf 235)\]"
        readonly FG_BASE01="\[$(tput setaf 240)\]"
        readonly FG_BASE00="\[$(tput setaf 241)\]"
        readonly FG_BASE0="\[$(tput setaf 244)\]"
        #readonly FG_BASE1="\[$(tput setaf 245)\]"
        readonly FG_BASE1="\[$(tput setaf 4)\]"
        #readonly FG_BASE2="\[$(tput setaf 254)\]"
        readonly FG_BASE2="\[$(tput setaf 0)\]"
        readonly FG_BASE3="\[$(tput setaf 230)\]"
        readonly FG_BASE4="\[$(tput setaf 11)\]"

        readonly BG_BASE03="\[$(tput setab 234)\]"
        readonly BG_BASE02="\[$(tput setab 235)\]"
        readonly BG_BASE01="\[$(tput setab 240)\]"
        readonly BG_BASE00="\[$(tput setab 241)\]"
        readonly BG_BASE0="\[$(tput setab 244)\]"
        #readonly BG_BASE1="\[$(tput setab 245)\]"
        readonly BG_BASE1="\[$(tput setab 4)\]"
        #readonly BG_BASE2="\[$(tput setab 254)\]"
        readonly BG_BASE2="\[$(tput setab 0)\]"
        readonly BG_BASE3="\[$(tput setab 230)\]"
        readonly BG_BASE4="\[$(tput setab 11)\]"

        readonly FG_YELLOW="\[$(tput setaf 136)\]"
        readonly FG_ORANGE="\[$(tput setaf 166)\]"
        readonly FG_RED="\[$(tput setaf 160)\]"
        readonly FG_MAGENTA="\[$(tput setaf 125)\]"
        readonly FG_VIOLET="\[$(tput setaf 61)\]"
        readonly FG_BLUE="\[$(tput setaf 33)\]"
        readonly FG_CYAN="\[$(tput setaf 37)\]"
        readonly FG_GREEN="\[$(tput setaf 64)\]"

        readonly BG_YELLOW="\[$(tput setab 136)\]"
        readonly BG_ORANGE="\[$(tput setab 166)\]"
        readonly BG_RED="\[$(tput setab 160)\]"
        readonly BG_MAGENTA="\[$(tput setab 125)\]"
        readonly BG_VIOLET="\[$(tput setab 61)\]"
        readonly BG_BLUE="\[$(tput setab 33)\]"
        readonly BG_CYAN="\[$(tput setab 37)\]"
        readonly BG_GREEN="\[$(tput setab 64)\]"
     else
        readonly FG_BASE03="\[$(tput setaf 8)\]"
        readonly FG_BASE02="\[$(tput setaf 0)\]"
        readonly FG_BASE01="\[$(tput setaf 10)\]"
        readonly FG_BASE00="\[$(tput setaf 11)\]"
        readonly FG_BASE0="\[$(tput setaf 12)\]"
        readonly FG_BASE1="\[$(tput setaf 14)\]"
        readonly FG_BASE2="\[$(tput setaf 7)\]"
        readonly FG_BASE3="\[$(tput setaf 15)\]"

        readonly BG_BASE03="\[$(tput setab 8)\]"
        readonly BG_BASE02="\[$(tput setab 0)\]"
        readonly BG_BASE01="\[$(tput setab 10)\]"
        readonly BG_BASE00="\[$(tput setab 11)\]"
        readonly BG_BASE0="\[$(tput setab 12)\]"
        readonly BG_BASE1="\[$(tput setab 14)\]"
        readonly BG_BASE2="\[$(tput setab 7)\]"
        readonly BG_BASE3="\[$(tput setab 15)\]"

        readonly FG_YELLOW="\[$(tput setaf 3)\]"
        readonly FG_ORANGE="\[$(tput setaf 9)\]"
        readonly FG_RED="\[$(tput setaf 1)\]"
        readonly FG_MAGENTA="\[$(tput setaf 5)\]"
        readonly FG_VIOLET="\[$(tput setaf 13)\]"
        readonly FG_BLUE="\[$(tput setaf 4)\]"
        readonly FG_CYAN="\[$(tput setaf 6)\]"
        readonly FG_GREEN="\[$(tput setaf 2)\]"

        readonly BG_YELLOW="\[$(tput setab 3)\]"
        readonly BG_ORANGE="\[$(tput setab 9)\]"
        readonly BG_RED="\[$(tput setab 1)\]"
        readonly BG_MAGENTA="\[$(tput setab 5)\]"
        readonly BG_VIOLET="\[$(tput setab 13)\]"
        readonly BG_BLUE="\[$(tput setab 4)\]"
        readonly BG_CYAN="\[$(tput setab 6)\]"
        readonly BG_GREEN="\[$(tput setab 2)\]"
    fi

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly BOLD="\[$(tput bold)\]"

    if [[ -z "$PS_SYMBOL" ]]; then
      case "$(uname)" in
          Darwin)
              PS_SYMBOL=$PS_SYMBOL_DARWIN
              ;;
          Linux)
              PS_SYMBOL=$PS_SYMBOL_LINUX
              ;;
          *)
              PS_SYMBOL=$PS_SYMBOL_OTHER
      esac
    fi

    ps1() {
        local RET="$?"
        local bold=$(tput bold)
        local normal=$(tput sgr0)
        local PS1L="$BG_BASE1$FG_BASE2 \w $RESET"    
        local TIME="$(date +%H:%M:%S)"

        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $RET -eq 0 ]; then
            local BG_EXIT="$BG_GREEN"
            local FG_EXIT="$FG_GREEN"
            local RET_CODE="✓"
        else
            local BG_EXIT="$BG_RED"
            local FG_EXIT="$FG_RED"
            local RET_CODE="$RET ↵"
        fi

        PS1L+="$FG_BASE1$BG_EXIT$FG_BASE3 $PS_SYMBOL $RESET$FG_EXIT$RESET "
        local PS1RHS="$FG_EXIT$BG_EXIT$FG_BASE3 $RET_CODE $FG_BASE3$BG_BASE3$FG_BASE2 $TIME "
        #local PS1LHS="$BG_MAGENTA$FG_BASE3$PS1RHSTEXT $FG_MAGENTA$BG_BASE1"
        local PS1LHS=""
        local PS1RHS_stripped=$(sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <<<" $RET_CODE   $TIME ")  
    
        # Reference: https://en.wikipedia.org/wiki/ANSI_escape_code
        local Save='\e[s' # Save cursor position
        local Rest='\e[u' # Restore cursor to save point

        PS1="\[${Save}\e[${COLUMNS}C\e[${#PS1RHS_stripped}D${PS1RHS}${Rest}\]$RESET"
        PS1+="$PS1LHS\n"
        PS1+="$PS1L"
    }


    PROMPT_COMMAND=ps1
}
__powerline
unset __powerline
