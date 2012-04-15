#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Human readability
#PS1='[\u@\h \W]\$ '
#PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\] '
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -c -h'

#Safety features
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

#Make history more handy
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export EDITOR=nano
export PACMAN=pacman-color

# Colored man page
man() {
	env \
			LESS_TERMCAP_mb=$(printf "\e[01;31m") \
			LESS_TERMCAP_md=$(printf "\e[01;38;5;74m") \
			LESS_TERMCAP_me=$(printf "\e[0m") \
			LESS_TERMCAP_se=$(printf "\e[0m") \
			LESS_TERMCAP_so=$(printf "\e[38;5;246m") \
			LESS_TERMCAP_ue=$(printf "\e[0m") \
			LESS_TERMCAP_us=$(printf "\e[04;38;5;146m") \
		man "$@"
}

