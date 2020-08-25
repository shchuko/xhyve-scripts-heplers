#!/bin/bash

if [[ $# == 1 ]]; then
	NAME="$1"
else
	NAME="booter_$(date +%s).img"
fi

mkfile 512M "$NAME"

gpt create "$NAME" # GPT Partition table
gpt add -b 2048 -i 1 -s 524288 -t C12A7328-F81F-11D2-BA4B-00A0C93EC93B "$NAME"    # 256M EFI Partition
gpt add -b 526336 -i 2 -s 522207 -t 0FC63DAF-8483-4772-8E79-3D69D8477DE4 "$NAME"  # 255N Linux Partition

RESULT=$(hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount "$NAME")
EXITCODE="$?"


echo "$RESULT"
if [[ "$EXITCODE" != 0 ]]; then
        exit "$EXITCODE"
fi

DISK_DEV=$(echo "$RESULT" | awk '{print $1; exit}')

newfs_msdos -F 32 -v EFI "${DISK_DEV}s1"	
newfs_msdos -F 32 -v Bootloader "${DISK_DEV}s2"	

hdiutil detach "$DISK_DEV" || echo "$DISK_DEV detaching errored, perform it manually"
echo "$NAME created"

