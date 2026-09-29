#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT" "$LEVEL_WORK/company/homes/$TARGET_USER";echo "Sensitive report" > "$LEVEL_WORK/company/$DEPARTMENT/$DOCUMENT";echo "Project plan" > "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT/plan.txt";echo "Private notes" > "$LEVEL_WORK/company/homes/$TARGET_USER/notes.txt";chown root:"$DEPARTMENT" "$LEVEL_WORK/company/$DEPARTMENT";chmod 2750 "$LEVEL_WORK/company/$DEPARTMENT";chown "$TARGET_USER:$WRONG_DEPARTMENT" "$LEVEL_WORK/company/$DEPARTMENT/$DOCUMENT";chmod 646 "$LEVEL_WORK/company/$DEPARTMENT/$DOCUMENT";chown root:"$DEPARTMENT" "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT";chmod 770 "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT";chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT/plan.txt";chmod 660 "$LEVEL_WORK/company/$DEPARTMENT/$PROJECT/plan.txt";chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/company/homes/$TARGET_USER";chmod 755 "$LEVEL_WORK/company/homes/$TARGET_USER";chmod 600 "$LEVEL_WORK/company/homes/$TARGET_USER/notes.txt"
cat >> "$README_BUILD" <<TASK
Audit requirements:
1. company/company/$DEPARTMENT/$DOCUMENT is $TARGET_USER:$DEPARTMENT mode 640.
2. company/company/$DEPARTMENT/$PROJECT is root:$DEPARTMENT mode 2770.
3. company/company/homes/$TARGET_USER retains ownership and has mode 700.
Do not alter plan.txt or notes.txt.
TASK
finish_level
