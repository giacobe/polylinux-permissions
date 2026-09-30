#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/path/$PROJECT/archive"
echo "Archived design" > "$LEVEL_HOME/path/$PROJECT/archive/$DOCUMENT"
chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/path"
chmod 751 "$LEVEL_HOME/path"
chmod 750 "$LEVEL_HOME/path/$PROJECT" "$LEVEL_HOME/path/$PROJECT/archive"
chmod 640 "$LEVEL_HOME/path/$PROJECT/archive/$DOCUMENT"
if [ "$variant" -lt 2 ]; then chmod 740 "$LEVEL_HOME/path/$PROJECT"; else chmod 740 "$LEVEL_HOME/path/$PROJECT/archive"; fi
levelinstructions="The file path/$PROJECT/archive/$DOCUMENT already has the correct permissions. Members of $DEPARTMENT cannot traverse the complete path. Locate and repair the one blocking directory. Do not change the file. Run validate when finished and submit the printed key to the exercise grading form."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
