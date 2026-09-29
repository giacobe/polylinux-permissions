#!/bin/sh
cd "$INSTALL_ROOT" || exit 1
. ./resources.sh
derive_parameters
mkdir -p "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT" "$LEVEL_HOME/company/homes/$TARGET_USER";echo report > "$LEVEL_HOME/company/$DEPARTMENT/$DOCUMENT";echo plan > "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT/plan.txt";echo notes > "$LEVEL_HOME/company/homes/$TARGET_USER/notes.txt";chown root:"$DEPARTMENT" "$LEVEL_HOME/company/$DEPARTMENT";chmod 2750 "$LEVEL_HOME/company/$DEPARTMENT";chown "$TARGET_USER:$WRONG_DEPARTMENT" "$LEVEL_HOME/company/$DEPARTMENT/$DOCUMENT";chmod 646 "$LEVEL_HOME/company/$DEPARTMENT/$DOCUMENT";chown root:"$DEPARTMENT" "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT";chmod 770 "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT";chown "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT/plan.txt";chmod 660 "$LEVEL_HOME/company/$DEPARTMENT/$PROJECT/plan.txt";chown -R "$TARGET_USER:$DEPARTMENT" "$LEVEL_HOME/company/homes/$TARGET_USER";chmod 755 "$LEVEL_HOME/company/homes/$TARGET_USER";chmod 600 "$LEVEL_HOME/company/homes/$TARGET_USER/notes.txt"
levelinstructions="Audit: company/$DEPARTMENT/$DOCUMENT must be $TARGET_USER:$DEPARTMENT mode 640; company/$DEPARTMENT/$PROJECT root:$DEPARTMENT mode 2770; company/homes/$TARGET_USER mode 700. Preserve plan.txt and notes.txt. Run validate when finished and submit the printed key."
format_block "$levelinstructions" >> "$readMeLocation"
finish_level
