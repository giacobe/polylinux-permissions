#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/workspaces/$PROJECT";echo "Team draft" > "$LEVEL_WORK/workspaces/$PROJECT/draft.txt";chown root:"$WRONG_DEPARTMENT" "$LEVEL_WORK/workspaces/$PROJECT";chmod 2777 "$LEVEL_WORK/workspaces/$PROJECT";chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/workspaces/$PROJECT/draft.txt";chmod 660 "$LEVEL_WORK/workspaces/$PROJECT/draft.txt"
cat >> "$README_BUILD" <<TASK
Repair company/workspaces/$PROJECT: group $DEPARTMENT and mode 2770. Preserve draft.txt exactly.
TASK
finish_level
