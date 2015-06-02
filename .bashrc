#
# ~/.bashrc: executed by bash(1) for non-login shells.
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set a color-supporting term type on Solaris
if [[ $(uname -s) == SunOS ]];
then
  TERM=xtermc
  if [ -d "/opt/bin/csw" ];
  then
    PATH="${PATH}:/opt/bin/csw"
  fi
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# history completion bound to arrow keys (down, up)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt
# We need \[\] surround the non printing characters to avoid messing up bash estimation of PS1 size
# PS1='[\u@\h \W]\$ '
PS1=
# Add hostname if on a login shell
shopt -q login_shell && PS1='\[$(tput bold)\]\[$(tput setaf 1)\]\h\[$(tput sgr0)\] '
# Add username
PS1="${PS1}"'\[$(tput setaf 2)\]\[$(tput bold)\]\u\[$(tput sgr0)\]'
# Add working directory
PS1="${PS1}"'\[$(tput setaf 3)\]:\[$(tput setaf 4)\]\w\[$(tput sgr0)\]'
# Add $ or # symbol
PS1="${PS1}"' \$ '

# enable color support of ls and also add handy aliases
if [[ $(uname -s) == Linux ]]; then
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias sl='ls'
alias ls='ls -F'
alias ll='ls -l'
alias la='ll -a'

# safety features
alias rm='rm -I'
alias mv='mv -I'
alias cp='cp -I'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
