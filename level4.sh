#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/projects/$PROJECT";echo "Project data" > "$LEVEL_WORK/projects/$PROJECT/$DOCUMENT";chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/projects/$PROJECT";chmod 740 "$LEVEL_WORK/projects/$PROJECT";chmod 640 "$LEVEL_WORK/projects/$PROJECT/$DOCUMENT"
cat >> "$README_BUILD" <<TASK
Members of $DEPARTMENT must be able to list and traverse company/projects/$PROJECT. Repair only the project directory mode.
TASK
finish_level
