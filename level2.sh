#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/departments/$DEPARTMENT";echo "Department plan" > "$LEVEL_WORK/departments/$DEPARTMENT/$DOCUMENT";chown "$TARGET_USER:$WRONG_DEPARTMENT" "$LEVEL_WORK/departments/$DEPARTMENT/$DOCUMENT";chmod 640 "$LEVEL_WORK/departments/$DEPARTMENT/$DOCUMENT"
cat >> "$README_BUILD" <<TASK
The file company/departments/$DEPARTMENT/$DOCUMENT belongs to the $DEPARTMENT department.
Change only its group ownership to $DEPARTMENT.
TASK
finish_level
