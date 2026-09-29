#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/projects/$PROJECT"
printf '%s\n' "Project data" > "$LEVEL_WORK/projects/$PROJECT/$DOCUMENT"
chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/projects/$PROJECT"
chmod 750 "$LEVEL_WORK/projects/$PROJECT"
chmod 640 "$LEVEL_WORK/projects/$PROJECT/$DOCUMENT"
# Remove group traversal while leaving group read permission.
chmod 740 "$LEVEL_WORK/projects/$PROJECT"
cat >> "$README_BUILD" <<TASK
Members of $DEPARTMENT must be able to list and traverse company/projects/$PROJECT.
The owner requires full access and everyone else requires no access.
Repair only the project directory mode.
TASK
finish_level
