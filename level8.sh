#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/workspaces/$PROJECT"
printf '%s\n' "Team draft" > "$LEVEL_WORK/workspaces/$PROJECT/draft.txt"
chown root:"$DEPARTMENT" "$LEVEL_WORK/workspaces/$PROJECT"
chmod 2770 "$LEVEL_WORK/workspaces/$PROJECT"
chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/workspaces/$PROJECT/draft.txt"
chmod 660 "$LEVEL_WORK/workspaces/$PROJECT/draft.txt"
# Break both the workspace group and its access policy.
chgrp "$WRONG_DEPARTMENT" "$LEVEL_WORK/workspaces/$PROJECT"
chmod 2777 "$LEVEL_WORK/workspaces/$PROJECT"
cat >> "$README_BUILD" <<TASK
Repair company/workspaces/$PROJECT so its group is $DEPARTMENT.
The owner and group require full access, outsiders require no access,
and new entries must inherit the workspace group.
Preserve draft.txt exactly as it is.
TASK
finish_level
