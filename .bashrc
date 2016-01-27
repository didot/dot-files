#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

is_sunos() {
  [[ "$(uname -s)" == "SunOS" ]]
}

__setup_path() {
  if is_sunos; then
    # By default at work we have a very strange PATH setup, let's clean that up using Solaris defaults
    export PATH="/usr/local/bin:/usr/bin:/usr/dt/bin:/usr/openwin/bin:/usr/ucb"

    # Add support for OpenCSW packages if available
    if [[ -d /opt/csw/bin ]]; then
      export PATH="$PATH:/opt/csw/bin"
    fi
  fi

  if [[ -d ~/local/bin ]]; then
    export PATH="$PATH:~/local/bin"
  fi
}

__setup_env_variables() {
  if is_sunos; then
    # By default fancy $TERM like xterm-256color are not supported, so let's not pretend they are
    export TERM=xterm

    # set man pager
    export PAGER="less -s"
  fi

  if type nano &>/dev/null; then
    export EDITOR=nano
  elif type vim &>/dev/null; then
    export EDITOR=vim
  elif type vi &>/dev/null; then
    export EDITOR=vi
  fi
}

__setup_ps1() {
  __tput() {
    if [[ is_sunos && "$(which tput)" == "/usr/local/bin/tput" && -r "/usr/local/lib/terminfo/x/xterm-256color" ]]; then
      TERM=xterm-256color tput "$@"
    else
      tput "$@"
    fi
  }
  
  local red="$(__tput setaf 1)"
  local green="$(__tput setaf 2)"
  local yellow="$(__tput setaf 3)"
  local blue="$(__tput setaf 4)"
  local reset="$(__tput sgr0)"
  local bold="$(__tput bold)"

  # We need \[\] surround the non printing characters to avoid messing up bash estimation of PS1 size
  PS1=
  if shopt -q login_shell; then
     PS1="\[$bold\]\[$red\]\h\[$reset\] "
  fi
  # Add username
  PS1="$PS1\[$green\]\[$bold\]\u\[$reset\]"
  # Add working directory
  PS1="$PS1\[$yellow\]:\[$blue\]\w\[$reset\]"
  # Add $ or # symbol
  PS1="$PS1 \$ "
}

__setup_history() {
  # don't put duplicate lines or lines starting with space in the history.
  # See bash(1) for more options
  HISTCONTROL=ignoreboth

  # append to the history file, don't overwrite it
  shopt -s histappend

  # Store history every time a command finishes
  PROMPT_COMMAND='history -a'

  # for setting history length see HISTSIZE (and if needed HISTFILESIZE) in bash(1)
  # however it looks like this feature is somewhat broken with bash v3 on solaris when logging in from ssh, so it is just enabled on bash v4
  if (bash --version | grep "bash, version 3">/dev/null); then
    export HISTSIZE=20000
  else
    export HISTSIZE=-1
  fi

  # history completion bound to arrow keys (down, up)
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
}

# Setup well-known aliases, and source .bash_aliases and .bash_aliases.d/* if they exist
__setup_aliases() {
  # enable color support of ls and also add handy aliases
  if ls --version &>/dev/null; then
    alias ls='ls --color=auto --classify --human-readable'
  else
    alias ls='ls -F -h'
  fi

  if grep --version &>/dev/null; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi

  # some more ls aliases
  alias sl='ls'
  alias ll='ls -l'
  alias la='ll --all'

  if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
  fi

  for alias_file in ~/.bash_aliases.d/*; do
    if [[ -f "$alias_file" ]]; then
      . "$alias_file"
    fi
  done
}

__setup_curses() {
  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize
}

__setup_path
__setup_env_variables
__setup_ps1
__setup_history
__setup_aliases
__setup_curses

if shopt -q login_shell; then
  # Because it looks cool when logging in from an SSH session :-)
  w
fi
