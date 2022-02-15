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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

CURRENT_ARCHITECTURE="($(uname -m))"

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[01;36m\]$CURRENT_ARCHITECTURE\[\033[00m\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\] \$ "
    alias ls='ls -G'
else
    PS1="$CURRENT_ARCHITECTURE\u@\h:\w\$ "
fi

unset color_prompt

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias whereis='which -a'

# Update your path to put to put the appropriate brew location first
# depending on your architecture
if [[ "$CURRENT_ARCHITECTURE" == "x86_64" ]]; then
  BREW_BIN="/usr/local/bin"
  PATH=$BREW_BIN:$PATH
elif [[ "$CURRENT_ARCHITECTURE" == "arm64" ]]; then
  BREW_BIN="/opt/homebrew/bin"
  PATH=$BREW_BIN:$PATH
fi



# Source Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export BASH_SILENCE_DEPRECATION_WARNING=1
