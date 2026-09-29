#!/bin/sh
set -eu
cd "$(dirname "$0")"
INSTALL_ROOT=$(pwd)
LAB_ID=polylinux-permissions
LAB_TITLE='Users, Groups, and Permissions'
SYSTEM_PASSWORD=${SYSTEM_PASSWORD:-systemPassword}
LEVEL_PASSWORD_ROOT=${LEVEL_PASSWORD_ROOT:-levelPassword}
currentDate=${CURRENT_DATE:-$(date +%Y-%m-%d)}
export INSTALL_ROOT LAB_ID LAB_TITLE SYSTEM_PASSWORD LEVEL_PASSWORD_ROOT currentDate
. "$INSTALL_ROOT/polylinux-common.sh"
. "$INSTALL_ROOT/resources.sh"
confirmation=n
while [ "$confirmation" != y ];do printf 'Enter your email address: ';IFS= read -r raw_user;normalized=$(normalize_email "$raw_user");validate_email "$normalized"||{ echo 'That address is not valid.' >&2;continue;};printf 'The exercise will use %s. Is that correct? (y/n) ' "$normalized";IFS= read -r confirmation;done
USER_ID=$(normalize_email "$raw_user");EXERCISE_CODE=$(exercise_code_from_date "$currentDate");export USER_ID EXERCISE_CODE
for cmd in addgroup adduser awk base64 cat chmod chgrp chown cp cut date find fold grep id ls mkdir mv passwd printf rm sed sha256sum sleep sort stat su sudo tail tr usermod;do command_required "$cmd";done
mkdir -p /home /usr/bin /etc/sudoers.d
for g in management engineering sales support sysadmin;do grep -q "^$g:" /etc/group||addgroup "$g";done
for pair in "management:$MANAGEMENT_USERS" "engineering:$ENGINEERING_USERS" "sales:$SALES_USERS" "support:$SUPPORT_USERS";do g=${pair%%:*};users=${pair#*:};for u in $users;do id "$u" >/dev/null 2>&1||adduser -D -H -G "$g" -s /bin/sh "$u";done;done
cat >/etc/sudoers.d/polylinux-permissions <<'SUDOERS'
%sysadmin ALL=(ALL:ALL) NOPASSWD: ALL
SUDOERS
chmod 440 /etc/sudoers.d/polylinux-permissions
cp "$INSTALL_ROOT/nextlevel" "$INSTALL_ROOT/prevlevel" "$INSTALL_ROOT/validate" /usr/bin/
chmod 755 /usr/bin/nextlevel /usr/bin/prevlevel /usr/bin/validate
. "$INSTALL_ROOT/polylinux-parallel-runtime.sh"
prepare_standard_accounts
echo "Exercise code: $EXERCISE_CODE"
start_standard_levels
