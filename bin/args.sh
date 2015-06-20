#!/bin/sh

function print_args {
  local first=true
  for arg in "$@"
  do
    if $first;
    then
      first=false
    else
      echo -n " "
    fi

    echo -n "'$arg'"
  done

  echo
}

print_args "$@"

