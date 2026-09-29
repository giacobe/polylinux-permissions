#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/shared/$DEPARTMENT";echo "Starter file" > "$LEVEL_WORK/shared/$DEPARTMENT/starter.txt";chown -R root:"$DEPARTMENT" "$LEVEL_WORK/shared/$DEPARTMENT";chmod 770 "$LEVEL_WORK/shared/$DEPARTMENT";chmod 660 "$LEVEL_WORK/shared/$DEPARTMENT/starter.txt"
cat >> "$README_BUILD" <<TASK
Configure company/shared/$DEPARTMENT so new entries inherit the $DEPARTMENT group while preserving ordinary access.
TASK
finish_level
