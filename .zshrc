if [ ! -d ~/.dynamic-colors ]; then git clone https://github.com/sos4nt/dynamic-colors ~/.dynamic-colors; fi
export PATH="$HOME/.dynamic-colors/bin:$PATH"
source $HOME/.dynamic-colors/completions/dynamic-colors.zsh

# Apply color theme dyanmically when using st
if [ "$TERM" = "st-256color" ]; then
  dynamic-colors switch solarized-dark
fi
if [ "$TERM" = "stterm-256color"  ]; then
  dynamic-colors switch solarized-dark
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
  command ssh -o "PermitLocalCommand yes"  -o "Localcommand dynamic-colors switch earthy" "$@";
  dynamic-colors switch solarized-dark
}

