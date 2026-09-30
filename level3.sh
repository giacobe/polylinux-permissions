#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/reports"
echo "Internal report" > "$LEVEL_HOME/reports/$DOCUMENT"
chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/reports/$DOCUMENT"
chmod 604 "$LEVEL_HOME/reports/$DOCUMENT"
levelinstructions="Set reports/$DOCUMENT so the owner can read and write, the group can read, and everyone else has no access. Preserve its owner and group. Run validate when finished and submit the printed key to the exercise grading form."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
