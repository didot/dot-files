#
# ~/.bashrc: executed by bash(1) for non-login shells.
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set a color-supporting term type on Solaris
[[ $(uname -s) == SunOS ]] && TERM=xtermc

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
# PS1='[\u@\h \W]\$ '
shopt -q login_shell && PS1='$(tput bold)$(tput setaf 1)\h$(tput sgr0) ' || PS1=
PS1+='$(tput setaf 2)$(tput bold)\u$(tput sgr0)$(tput setaf 3):$(tput setaf 4)\w$(tput sgr0) \$ '

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias sl='ls'
alias ls='ls -F'
alias ll='ls -l'
alias la='ll -a'

# safety features
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
