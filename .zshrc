# Apply color theme dyanmically when using st
if [ "$TERM" = "st-256color"  ]; then
  printf '\x1b]4;7;%s\a' $(grep -oP 'foreground:\s+\K\S+' ~/.Xresources | head -1)
  function setThemeInSt(){
     grep -oP 'color[1-9][0-9]?:\s+\S+' ~/.Xresources | sed -r 's/color([0-9]*):/\1/' | awk '{printf "\x1b]4;"$1";"$2"\a"}'
     printf '\x1b]4;7;%s\a\x1b]4;0;%s\a' $(grep -oP 'foreground:\s+\K\S+' ~/.Xresources | head -1) $(grep -oP 'background:\s+\K\S+' ~/.Xresources | head -1)
  }
  setThemeInSt
  
fi

source /home/omar/antigen.zsh

DEFAULT_USER=$USER
POWERLEVEL9K_MODE="awesome-fontconfig"
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_joined rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time time)
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle docker
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.

#antigen theme robbyrussell
antigen theme bhilburn/powerlevel9k powerlevel9k


# Tell Antigen that you're done.
antigen apply

function ssh(){                                       
  command ssh "$@";
  printf '\x1b]10;%s\a\x1b]11;%s\a\x1b]708;%2$s\a' $(grep -oP 'foreground:\s+\K\S+' ~/.Xresources | head -1) $(grep -oP 'background:\s+\K\S+' ~/.Xresources | head -1)
}

   

