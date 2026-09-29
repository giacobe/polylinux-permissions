#!/bin/sh
set -eu
cd /root
. ./resources.sh
derive_level_parameters
begin_level
mkdir -p "$LEVEL_WORK/path/$PROJECT/archive";echo "Archived design" > "$LEVEL_WORK/path/$PROJECT/archive/$DOCUMENT";chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_WORK/path";chmod 751 "$LEVEL_WORK/path";chmod 750 "$LEVEL_WORK/path/$PROJECT" "$LEVEL_WORK/path/$PROJECT/archive";chmod 640 "$LEVEL_WORK/path/$PROJECT/archive/$DOCUMENT";if [ "$variant" -lt 2 ];then chmod 740 "$LEVEL_WORK/path/$PROJECT";else chmod 740 "$LEVEL_WORK/path/$PROJECT/archive";fi
cat >> "$README_BUILD" <<TASK
The file company/path/$PROJECT/archive/$DOCUMENT is correct. Find and repair the one directory blocking $DEPARTMENT traversal. Do not change the file.
TASK
finish_level
