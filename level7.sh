#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/shared/$DEPARTMENT";echo starter > "$LEVEL_HOME/shared/$DEPARTMENT/starter.txt";chown -R root:"$DEPARTMENT" "$LEVEL_HOME/shared/$DEPARTMENT";chmod 770 "$LEVEL_HOME/shared/$DEPARTMENT";chmod 660 "$LEVEL_HOME/shared/$DEPARTMENT/starter.txt"
levelinstructions="Configure shared/$DEPARTMENT so new entries inherit the $DEPARTMENT group while preserving ordinary access. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
