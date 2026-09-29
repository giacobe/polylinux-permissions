#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/audit/$DEPARTMENT"
printf '%s\n' "Quarterly data" > "$LEVEL_WORK/audit/$DEPARTMENT/$DOCUMENT"
printf '%s\n' "Do not alter this control file" > "$LEVEL_WORK/audit/$DEPARTMENT/control.txt"
chown root:"$DEPARTMENT" "$LEVEL_WORK/audit/$DEPARTMENT"
chmod 2750 "$LEVEL_WORK/audit/$DEPARTMENT"
chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/audit/$DEPARTMENT/$DOCUMENT"
chmod 640 "$LEVEL_WORK/audit/$DEPARTMENT/$DOCUMENT"
chown root:"$DEPARTMENT" "$LEVEL_WORK/audit/$DEPARTMENT/control.txt"
chmod 440 "$LEVEL_WORK/audit/$DEPARTMENT/control.txt"
# Introduce combined ownership and mode defects on only the target document.
chown root:root "$LEVEL_WORK/audit/$DEPARTMENT/$DOCUMENT"
chmod 666 "$LEVEL_WORK/audit/$DEPARTMENT/$DOCUMENT"
cat >> "$README_BUILD" <<TASK
Repair only company/audit/$DEPARTMENT/$DOCUMENT.
Its required owner and group are $TARGET_USER:$DEPARTMENT and its required mode is 640.
Do not alter control.txt or the audit directory.
TASK
finish_level
