#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/path/$PROJECT/archive";echo archive > "$LEVEL_HOME/path/$PROJECT/archive/$DOCUMENT";chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/path";chmod 751 "$LEVEL_HOME/path";chmod 750 "$LEVEL_HOME/path/$PROJECT" "$LEVEL_HOME/path/$PROJECT/archive";chmod 640 "$LEVEL_HOME/path/$PROJECT/archive/$DOCUMENT";if [ "$variant" -lt 2 ];then chmod 740 "$LEVEL_HOME/path/$PROJECT";else chmod 740 "$LEVEL_HOME/path/$PROJECT/archive";fi
levelinstructions="Find and repair the one directory blocking $DEPARTMENT traversal to path/$PROJECT/archive/$DOCUMENT. Do not change the file. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
