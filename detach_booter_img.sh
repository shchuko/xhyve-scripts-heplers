#!/bin/bash

if [[ $# < 1 ]]; then 
	echo "Wrong args"
	echo "Usage: ./detach_booter_img.sh DEV_PATH [MOUNTPOINT_A] [MOUNTPOINT_B]..."
	exit 1
fi

DEV="$1"
shift

for ARG in "$@"; do
	umount "$ARG" | exit 1
	echo "umount $ARG succeed"		
done

hdiutil detach "$DEV"

