#!/bin/bash

if [[ $# < 3 ]]; then
	echo "Wrong args"
	echo "Usage: './mount_booter_img.sh IMG_PATH S1_MOUNT_POINT S2_MOUNT_POINT'"
	exit 1
fi

IMAGE="$1"

RESULT=$(hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount "$IMAGE")
EXITCODE="$?"

echo "$RESULT"
if [[ "$EXITCODE" != 0 ]]; then
	exit "$EXITCODE"
fi

DEV_LIST=$(echo "$RESULT" | awk 'NR>1 {print $1}')

counter=2
while IFS= read -r DEV; do
	MOUNT_POINT=$(eval "echo \${$counter}") 

	echo "Mounting $DEV to $MOUNT_POINT" 
	mount -t msdos "$DEV" "$MOUNT_POINT"
	
	let counter=counter+1
done <<< "$DEV_LIST"


