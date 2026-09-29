#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/departments/$DEPARTMENT";echo plan > "$LEVEL_HOME/departments/$DEPARTMENT/$DOCUMENT";chown "$TARGET_USER:$WRONG_DEPARTMENT" "$LEVEL_HOME/departments/$DEPARTMENT/$DOCUMENT";chmod 640 "$LEVEL_HOME/departments/$DEPARTMENT/$DOCUMENT"
levelinstructions="Change only departments/$DEPARTMENT/$DOCUMENT group ownership to $DEPARTMENT. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
