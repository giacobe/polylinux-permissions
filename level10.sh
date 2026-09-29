#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT"
mkdir -p "$LEVEL_WORK/company/homes/$TARGET_USER"
printf '%s\n' "Sensitive report" > "$LEVEL_WORK/company/$DEPARTMENT/$DOCUMENT"
printf '%s\n' "Project plan" > "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT/plan.txt"
printf '%s\n' "Private notes" > "$LEVEL_WORK/company/homes/$TARGET_USER/notes.txt"
chown root:"$DEPARTMENT" "$LEVEL_WORK/company/$DEPARTMENT"
chmod 2750 "$LEVEL_WORK/company/$DEPARTMENT"
chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/company/$DEPARTMENT/$DOCUMENT"
chmod 640 "$LEVEL_WORK/company/$DEPARTMENT/$DOCUMENT"
chown root:"$DEPARTMENT" "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT"
chmod 2770 "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT"
chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT/plan.txt"
chmod 660 "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT/plan.txt"
chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/company/homes/$TARGET_USER"
chmod 700 "$LEVEL_WORK/company/homes/$TARGET_USER"
chmod 600 "$LEVEL_WORK/company/homes/$TARGET_USER/notes.txt"
# Introduce three independent defects.
chgrp "$WRONG_DEPARTMENT" "$LEVEL_WORK/company/$DEPARTMENT/$DOCUMENT"
chmod 646 "$LEVEL_WORK/company/$DEPARTMENT/$DOCUMENT"
chmod 770 "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT"
chmod 755 "$LEVEL_WORK/company/homes/$TARGET_USER"
cat >> "$README_BUILD" <<TASK
Complete the company permissions audit.

1. company/company/$DEPARTMENT/$DOCUMENT must be owned by $TARGET_USER:$DEPARTMENT with mode 640.
2. company/company/$DEPARTMENT/$PROJECT must be owned by root:$DEPARTMENT with mode 2770.
3. company/company/homes/$TARGET_USER must retain its current owner and group and have mode 700.

Do not alter plan.txt or notes.txt.
TASK
finish_level
