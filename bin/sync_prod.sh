#!/bin/bash

# PROD is an array of machines to copy files to
# $1 is a file containing lines "src dest-on-remote
# limitations
# - does not support whitespaces in filenames
# - #file x #machines scp calls

for machine in $PROD
do
  while read -r line || [[ -n "$line" ]]
  do
    srcdest=($line)
    ~/bin/args.sh scp ${srcdest[0]} ${machine}:${srcdest[1]}
  done < $1
done

