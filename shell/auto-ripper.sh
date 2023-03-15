#!/bin/bash

# This bash program runs in a loop, waiting for a cdrom to be inserted into the
# given location, $CDROM. Once a CD is inserted, it rips it to FLACs, creates a
# tar archive, and moves it to another destination via scp ($DEST). These two
# given values are passed along as the first and second positional arguments.

# Once the CD is ripped, it is ejected so a human can insert the next disc in
# preparation for the next iteration of the loop.

CDROM=$1
DEST=$2

function copy_to_waiter
{
    scp $1 $DEST
    rm $1
}

# We get the status of the disk and return 1 to the while loop if the disk is
# ready to read. This causes the inner while loop to exit so the outer one can
# continue.
function check_if_disk_present
{
    status=$(lshw -xml -c disk 2> /dev/null | yq -p xml '.. | select(. == "'${CDROM}'") | parent | parent | .configuration.setting[] | select(.+@id == "status").+@value' | head -n 1)
    echo $status
    if [ "$status" = "ready" ]; then
        return 1
    fi
    echo "Disc not found"
    return 0
}

while :
do
    # If the disk is not present, wait 5 seconds and check again.
    while check_if_disk_present
    do
        sleep 5
    done
    abcde -xNo flac -j 12 -d $CDROM
    output=$(ls)
    tar -c -f PART.$output.tar $output
    mv PART.$output.tar ./.moving/$output.tar
    rm -rf $output
    copy_to_waiter ./.moving/$output.tar
done
