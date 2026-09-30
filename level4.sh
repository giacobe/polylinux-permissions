#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/projects/$PROJECT"
echo "Project data" > "$LEVEL_HOME/projects/$PROJECT/$DOCUMENT"
chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/projects/$PROJECT"
chmod 740 "$LEVEL_HOME/projects/$PROJECT"
chmod 640 "$LEVEL_HOME/projects/$PROJECT/$DOCUMENT"
levelinstructions="Members of $DEPARTMENT must be able to list and traverse projects/$PROJECT. The owner requires full access and everyone else requires no access. Repair only the project directory mode. Run validate when finished and submit the printed key to the exercise grading form."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
