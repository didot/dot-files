#!/bin/sh

for f in .??*
do
    if [ "$f" = ".git" ]
    then
        continue
    fi

    ln -s "$(pwd)/$f" "${HOME}/$f"

    if [ $? -ne 0 ]
    then
        echo -n "Retry with --force ? [Y/n] "
        read r
        case $r in
            [nN][oO]|[nN])
                ;;
            *)
                ln -fs "$(pwd)/$f" "${HOME}/$f"
                ;;
        esac
    fi
done
