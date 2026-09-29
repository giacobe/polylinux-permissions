#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/workspaces/$PROJECT";echo draft > "$LEVEL_HOME/workspaces/$PROJECT/draft.txt";chown root:"$WRONG_DEPARTMENT" "$LEVEL_HOME/workspaces/$PROJECT";chmod 2777 "$LEVEL_HOME/workspaces/$PROJECT";chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/workspaces/$PROJECT/draft.txt";chmod 660 "$LEVEL_HOME/workspaces/$PROJECT/draft.txt"
levelinstructions="Repair workspaces/$PROJECT: group $DEPARTMENT and mode 2770. Preserve draft.txt. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
