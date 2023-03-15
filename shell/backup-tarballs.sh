#!/bin/bash

# This script loops over the files in the current directory and scp's them to a
# given destination.

DEST=$1

function check_for_tarballs
{
    if [ $(ls *.tar 2> /dev/null) ]; then
        return 1
    fi
    echo "No tarballs found"
    return 0
}


while :
do
    # If there are no tarballs to copy, wait a minute and check again.
    while check_for_tarballs
    do
        sleep 60
    done
    for filename in *.tar
    do
        echo "Moving '$filename' to '$DEST'"
        scp $filename $DEST
        rm $filename
    done
done
