#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/records";echo "Confidential company record" > "$LEVEL_WORK/records/$DOCUMENT";chown root:"$DEPARTMENT" "$LEVEL_WORK/records/$DOCUMENT";chmod 640 "$LEVEL_WORK/records/$DOCUMENT"
cat >> "$README_BUILD" <<TASK
Change the owner of company/records/$DOCUMENT to $TARGET_USER.
Preserve the current group ownership and permissions.
TASK
finish_level
