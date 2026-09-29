#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/homes/$TARGET_USER/private"
printf '%s\n' "Personal notes" > "$LEVEL_WORK/homes/$TARGET_USER/private/notes.txt"
chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/homes/$TARGET_USER"
chmod 700 "$LEVEL_WORK/homes/$TARGET_USER"
chmod 700 "$LEVEL_WORK/homes/$TARGET_USER/private"
chmod 600 "$LEVEL_WORK/homes/$TARGET_USER/private/notes.txt"
# Expose the simulated home directory.
chmod 755 "$LEVEL_WORK/homes/$TARGET_USER"
cat >> "$README_BUILD" <<TASK
The simulated home directory company/homes/$TARGET_USER must be accessible only by $TARGET_USER.
Repair only that home directory's mode.
TASK
finish_level
