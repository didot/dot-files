#!/bin/sh

for f in .*
do
    if [ "$f" = "." -o "$f" = ".." -o "$f" = ".git" ];
    then
        continue
    fi

    if [ -e "${HOME}/$f" ];
    then
        echo "Backing up ${HOME}/$f to ${HOME}/${f}.bak"
        mv "${HOME}/$f" "${HOME}/${f}.bak"
    fi

    ln -s "$(pwd)/$f" "${HOME}/$f"
    unset f
done
