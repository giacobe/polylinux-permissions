#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/shared/$DEPARTMENT"
echo "Starter file" > "$LEVEL_HOME/shared/$DEPARTMENT/starter.txt"
chown -R root:"$DEPARTMENT" "$LEVEL_HOME/shared/$DEPARTMENT"
chmod 770 "$LEVEL_HOME/shared/$DEPARTMENT"
chmod 660 "$LEVEL_HOME/shared/$DEPARTMENT/starter.txt"
levelinstructions="The directory shared/$DEPARTMENT already has the correct ordinary access permissions. Configure it so newly created entries inherit the $DEPARTMENT group. Change nothing else. Run validate when finished and submit the printed key to the exercise grading form."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
