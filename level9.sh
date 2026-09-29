#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/audit/$DEPARTMENT";echo "Quarterly data" > "$LEVEL_WORK/audit/$DEPARTMENT/$DOCUMENT";echo "Do not alter this control file" > "$LEVEL_WORK/audit/$DEPARTMENT/control.txt";chown root:"$DEPARTMENT" "$LEVEL_WORK/audit/$DEPARTMENT";chmod 2750 "$LEVEL_WORK/audit/$DEPARTMENT";chown root:root "$LEVEL_WORK/audit/$DEPARTMENT/$DOCUMENT";chmod 666 "$LEVEL_WORK/audit/$DEPARTMENT/$DOCUMENT";chown root:"$DEPARTMENT" "$LEVEL_WORK/audit/$DEPARTMENT/control.txt";chmod 440 "$LEVEL_WORK/audit/$DEPARTMENT/control.txt"
cat >> "$README_BUILD" <<TASK
Repair only company/audit/$DEPARTMENT/$DOCUMENT to $TARGET_USER:$DEPARTMENT with mode 640. Do not alter control.txt or the directory.
TASK
finish_level
