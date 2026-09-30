#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/departments/$DEPARTMENT"
echo "Department plan" > "$LEVEL_HOME/departments/$DEPARTMENT/$DOCUMENT"
chown "$TARGET_USER:$WRONG_DEPARTMENT" "$LEVEL_HOME/departments/$DEPARTMENT/$DOCUMENT"
chmod 640 "$LEVEL_HOME/departments/$DEPARTMENT/$DOCUMENT"
levelinstructions="The file departments/$DEPARTMENT/$DOCUMENT belongs to the $DEPARTMENT department. Change only its group ownership to $DEPARTMENT. Run validate when finished and submit the printed key to the exercise grading form."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
