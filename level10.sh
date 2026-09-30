#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT" "$LEVEL_HOME/company/homes/$TARGET_USER"
echo "Sensitive report" > "$LEVEL_HOME/company/$DEPARTMENT/$DOCUMENT"
echo "Project plan" > "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT/plan.txt"
echo "Private notes" > "$LEVEL_HOME/company/homes/$TARGET_USER/notes.txt"
chown root:"$DEPARTMENT" "$LEVEL_HOME/company/$DEPARTMENT"
chmod 2750 "$LEVEL_HOME/company/$DEPARTMENT"
chown "$TARGET_USER:$WRONG_DEPARTMENT" "$LEVEL_HOME/company/$DEPARTMENT/$DOCUMENT"
chmod 646 "$LEVEL_HOME/company/$DEPARTMENT/$DOCUMENT"
chown root:"$DEPARTMENT" "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT"
chmod 770 "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT"
chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT/plan.txt"
chmod 660 "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT/plan.txt"
chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/company/homes/$TARGET_USER"
chmod 755 "$LEVEL_HOME/company/homes/$TARGET_USER"
chmod 600 "$LEVEL_HOME/company/homes/$TARGET_USER/notes.txt"
levelinstructions="Complete the audit. company/$DEPARTMENT/$DOCUMENT must be $TARGET_USER:$DEPARTMENT mode 640. company/$DEPARTMENT/$PROJECT must be root:$DEPARTMENT mode 2770. company/homes/$TARGET_USER must retain its owner and group and have mode 700. Do not alter plan.txt or notes.txt. Run validate when finished and submit the printed key to the exercise grading form."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
