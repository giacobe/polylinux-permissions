#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/shared/$DEPARTMENT"
printf '%s\n' "Starter file" > "$LEVEL_WORK/shared/$DEPARTMENT/starter.txt"
chown -R root:"$DEPARTMENT" "$LEVEL_WORK/shared/$DEPARTMENT"
chmod 2770 "$LEVEL_WORK/shared/$DEPARTMENT"
chmod 660 "$LEVEL_WORK/shared/$DEPARTMENT/starter.txt"
# Remove setgid while preserving ordinary collaboration permissions.
chmod 770 "$LEVEL_WORK/shared/$DEPARTMENT"
cat >> "$README_BUILD" <<TASK
The directory company/shared/$DEPARTMENT already has the correct ordinary access permissions.
Configure it so newly created entries inherit the $DEPARTMENT group.
Change nothing else.
TASK
finish_level
