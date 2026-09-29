#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/reports";echo "Internal report" > "$LEVEL_WORK/reports/$DOCUMENT";chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/reports/$DOCUMENT";chmod 604 "$LEVEL_WORK/reports/$DOCUMENT"
cat >> "$README_BUILD" <<TASK
Set company/reports/$DOCUMENT so the owner can read and write, the group can read, and everyone else has no access. Preserve its owner and group.
TASK
finish_level
