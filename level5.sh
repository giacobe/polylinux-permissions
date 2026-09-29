#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/homes/$TARGET_USER/private";echo "Personal notes" > "$LEVEL_WORK/homes/$TARGET_USER/private/notes.txt";chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/homes/$TARGET_USER";chmod 755 "$LEVEL_WORK/homes/$TARGET_USER";chmod 700 "$LEVEL_WORK/homes/$TARGET_USER/private";chmod 600 "$LEVEL_WORK/homes/$TARGET_USER/private/notes.txt"
cat >> "$README_BUILD" <<TASK
The simulated home directory company/homes/$TARGET_USER must be accessible only by $TARGET_USER. Repair only that directory mode.
TASK
finish_level
