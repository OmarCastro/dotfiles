# .bashrc

# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# only run tmux if requested, by setting START_TMUX_FROM_WD_CACHE to true when starting a terminal.
if [ -z $TMUX ] && [ "$START_TMUX_FROM_WD_CACHE" == "True" ]; then
  export START_TMUX_FROM_WD_CACHE=
  unset START_TMUX_FROM_WD_CACHE
  if tmux ls | grep -vq attached; then
    exec tmux -2 attach-session -d
  else
    exec tmux -2 new-session \; setenv BASH_START_FROM_WD_CACHE True
  fi
  exit 0
fi

shopt -s autocd

bash_theme_local="dracula"
bash_theme_ssh="solarized-dark"

DYNAMIC_COLORS_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/dynamic-colors"
# import dynamic-colors
if [ ! -d "$DYNAMIC_COLORS_ROOT" ]; then git clone https://github.com/peterhoeg/dynamic-colors "$DYNAMIC_COLORS_ROOT"; fi
export PATH="$HOME/bin:$DYNAMIC_COLORS_ROOT/bin:$PATH"
source $DYNAMIC_COLORS_ROOT/completions/dynamic-colors.bash

dynamic-colors(){
    env -u TMUX dynamic-colors "$@"
}

# Apply color theme dyanmically when using a 256 or more colors terminal support
if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
  dynamic-colors switch $bash_theme_local
fi

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

# source additional bashrc for each environment (e.g. work environment)
if [ -d ~/bash_envs ]; then
  for f in ~/bash_envs/*/bashrc; do
    source $f
  done 
fi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'

bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'
bind 'TAB: menu-complete'
bind '"\e[Z":menu-complete-backward'
bind 'set colored-completion-prefix on'
bind 'set colored-stats on'
bind 'set completion-ignore-case on'


__powerline() {

    # Unicode symbols
    readonly PS_SYMBOL_DARWIN=''
    readonly PS_SYMBOL_LINUX='$'
    readonly PS_SYMBOL_OTHER='%'

    
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
    

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly BOLD="\[$(tput bold)\]"
    readonly EL="\[$(echo -e '\x1b[K')\]" # erase line

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

    ps0(){
        PS0='\[${PS1:$((PStimeStart=$(date +%s%3N), 0)):0}\]'
    }
    ps1() {
        local RET="$?"
        local TIMESTAMP="$(date +%s%3N)"
        local TIME="  $(date +%H:%M:%S)"

	    local sep=""
        
	      # get text duration text
        local duration_PS1RHS=""
        local duration_PS1RHS_stripped=""
        if [ -n ${PStimeStart:-""} ]; then
            local EXEC_TIME="$(( TIMESTAMP - PStimeStart))"
            export PStimeStart=""

            local timeMillis=$(( EXEC_TIME % 1000 ))
            local timeSeconds=$(( (EXEC_TIME / 1000) % 60 ))
            local timeMinutes=$(( EXEC_TIME / 60000 ))
            local duration_text="$([[ $timeMinutes -eq "0" ]] && printf '%d.%03d' $timeSeconds $timeMillis || printf '%02d:%02d.%03d' $timeMinutes $timeSeconds $timeMillis)"
            duration_text="$duration_text Dur"
            duration_PS1="$BG_ORANGE$sep$FG_BASE02 $duration_text $FG_ORANGE"
        fi

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

        local PS1_top="$BG_BLUE$FG_BASE02 \w $FG_BLUE$BG_YELLOW$sep$FG_BASE02 $TIME $FG_YELLOW$duration_PS1$BG_EXIT$sep$FG_BASE02 $RET_CODE $FG_EXIT$BG_BASE03$sep$EL"	
        local PS1_bottom="$BOLD $PS_SYMBOL ❯ $RESET"

        PS1="$PS1_top$RESET\n$PS1_bottom"
    
    }
    ps2(){
        PS2="$BOLD...❯ $RESET"
    }
    ps0
    PROMPT_COMMAND=ps1
    ps2
}

function __cache_working_directory() {
  function __cache_wd_aux() {
    mkdir -p ~/.cache/.bashrc.d
    pwd > ~/.cache/.bashrc.d/cwd
    }

    if [[ -r ~/.cache/.bashrc.d/cwd ]]; then
        cd "$(cat ~/.cache/.bashrc.d/cwd)"
    fi
    PROMPT_COMMAND="$PROMPT_COMMAND;__cache_wd_aux"
}

ssh(){
  local executable="ssh"
  local sshrc_home=${SSHHOME:=~}

  # if there is a .sshrc and sshrc is installed use it instead
  if [ -r $sshrc_home/.sshrc ] && command -v sshrc &> /dev/null; then
    executable="sshrc"
  fi

  command "$executable" -o "PermitLocalCommand yes" -o "Localcommand env -u TMUX dynamic-colors switch $bash_theme_ssh" "$@"
  local return_code=$?
  dynamic-colors switch $bash_theme_local
  return $return_code
}

function __has_param() {
    local terms="$1"
    shift

    for term in $terms; do
        for arg; do
            if [[ $arg == $term ]]; then
                return 0
            fi
        done
    done
    return 1
}

tail(){
  #adds colored line number when using --follow
  if __has_param '-f --follow -f*' "$@"; then
    command tail "$@" |  awk '{printf("\x1B[0;32m%6s║\x1B[0m %s\n", NR, $0)}'
  else
    command tail "$@"
  fi
}

__powerline
unset __powerline

# only use working_directory caching on tmux
if [ ! -z $TMUX  ] && tmux show-environment BASH_START_FROM_WD_CACHE > /dev/null; then
    __cache_working_directory
fi
unset __cache_working_directory
