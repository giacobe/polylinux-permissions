#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/audit/$DEPARTMENT";echo data > "$LEVEL_HOME/audit/$DEPARTMENT/$DOCUMENT";echo control > "$LEVEL_HOME/audit/$DEPARTMENT/control.txt";chown root:"$DEPARTMENT" "$LEVEL_HOME/audit/$DEPARTMENT";chmod 2750 "$LEVEL_HOME/audit/$DEPARTMENT";chown root:root "$LEVEL_HOME/audit/$DEPARTMENT/$DOCUMENT";chmod 666 "$LEVEL_HOME/audit/$DEPARTMENT/$DOCUMENT";chown root:"$DEPARTMENT" "$LEVEL_HOME/audit/$DEPARTMENT/control.txt";chmod 440 "$LEVEL_HOME/audit/$DEPARTMENT/control.txt"
levelinstructions="Repair only audit/$DEPARTMENT/$DOCUMENT to $TARGET_USER:$DEPARTMENT mode 640. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
