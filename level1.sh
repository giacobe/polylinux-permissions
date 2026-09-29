#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/records";echo "Confidential company record" > "$LEVEL_HOME/records/$DOCUMENT";chown root:"$DEPARTMENT" "$LEVEL_HOME/records/$DOCUMENT";chmod 640 "$LEVEL_HOME/records/$DOCUMENT"
levelinstructions="Change the owner of records/$DOCUMENT to $TARGET_USER. Preserve group and permissions. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
