#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/workspaces/$PROJECT"
echo "Team draft" > "$LEVEL_HOME/workspaces/$PROJECT/draft.txt"
chown root:"$WRONG_DEPARTMENT" "$LEVEL_HOME/workspaces/$PROJECT"
chmod 2777 "$LEVEL_HOME/workspaces/$PROJECT"
chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/workspaces/$PROJECT/draft.txt"
chmod 660 "$LEVEL_HOME/workspaces/$PROJECT/draft.txt"
levelinstructions="Repair workspaces/$PROJECT so its group is $DEPARTMENT and its mode is 2770. Preserve draft.txt exactly as it is. Run validate when finished and submit the printed key to the exercise grading form."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
