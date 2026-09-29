#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/homes/$TARGET_USER/private";echo notes > "$LEVEL_HOME/homes/$TARGET_USER/private/notes.txt";chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/homes/$TARGET_USER";chmod 755 "$LEVEL_HOME/homes/$TARGET_USER";chmod 700 "$LEVEL_HOME/homes/$TARGET_USER/private";chmod 600 "$LEVEL_HOME/homes/$TARGET_USER/private/notes.txt"
levelinstructions="Set homes/$TARGET_USER to mode 700 only. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
