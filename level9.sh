#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/audit/$DEPARTMENT"
echo "Quarterly data" > "$LEVEL_HOME/audit/$DEPARTMENT/$DOCUMENT"
echo "Do not alter this control file" > "$LEVEL_HOME/audit/$DEPARTMENT/control.txt"
chown root:"$DEPARTMENT" "$LEVEL_HOME/audit/$DEPARTMENT"
chmod 2750 "$LEVEL_HOME/audit/$DEPARTMENT"
chown root:root "$LEVEL_HOME/audit/$DEPARTMENT/$DOCUMENT"
chmod 666 "$LEVEL_HOME/audit/$DEPARTMENT/$DOCUMENT"
chown root:"$DEPARTMENT" "$LEVEL_HOME/audit/$DEPARTMENT/control.txt"
chmod 440 "$LEVEL_HOME/audit/$DEPARTMENT/control.txt"
levelinstructions="Repair only audit/$DEPARTMENT/$DOCUMENT. Its required owner and group are $TARGET_USER:$DEPARTMENT and its required mode is 640. Do not alter control.txt or the audit directory. Run validate when finished and submit the printed key to the exercise grading form."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
