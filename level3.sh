#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/reports";echo report > "$LEVEL_HOME/reports/$DOCUMENT";chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/reports/$DOCUMENT";chmod 604 "$LEVEL_HOME/reports/$DOCUMENT"
levelinstructions="Set reports/$DOCUMENT to mode 640 without changing owner or group. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
