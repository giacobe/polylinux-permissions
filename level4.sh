#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/projects/$PROJECT";echo data > "$LEVEL_HOME/projects/$PROJECT/$DOCUMENT";chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/projects/$PROJECT";chmod 740 "$LEVEL_HOME/projects/$PROJECT";chmod 640 "$LEVEL_HOME/projects/$PROJECT/$DOCUMENT"
levelinstructions="Repair projects/$PROJECT so owner has full access, $DEPARTMENT can list and traverse, and others have none. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
