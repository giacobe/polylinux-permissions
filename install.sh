#!/bin/sh
set -eu
[ "$(id -u)" -eq 0 ]||{ echo "Run /root/install.sh as root." >&2;exit 1;}
cd /root
required="company-data.sh resources.sh profile .profile nextlevel prevlevel validate"
for n in 1 2 3 4 5 6 7 8 9 10;do required="$required level$n.sh";done
for file in $required;do [ -f "/root/$file" ]||{ echo "Missing /root/$file" >&2;exit 1;};done
for command in sudo usermod sha256sum base64 stat;do command -v "$command" >/dev/null 2>&1||{ echo "Required command is missing: $command" >&2;exit 1;};done
mkdir -p /home /usr/local/bin /etc/sudoers.d
cp /root/profile /etc/profile
cp /root/nextlevel /root/prevlevel /root/validate /usr/local/bin/
chmod 755 /usr/local/bin/nextlevel /usr/local/bin/prevlevel /usr/local/bin/validate
chmod 755 /root/install.sh /root/resources.sh /root/company-data.sh /root/level*.sh /root/profile /root/.profile /root/validate /root/nextlevel /root/prevlevel
DATE_DECIMAL=$(date +%Y%m%d);EXERCISE_CODE=$(printf '%X\n' "$DATE_DECIMAL");export EXERCISE_CODE
confirmed=n
while [ "$confirmed" != y ]&&[ "$confirmed" != Y ];do printf 'Enter your email address: ';IFS= read -r USER_ID;echo "You entered: $USER_ID";printf 'Is this correct? (y/n): ';IFS= read -r confirmed;done
export USER_ID
. /root/company-data.sh
. /root/resources.sh
for group in $DEPARTMENTS sysadmin;do grep -q "^${group}:" /etc/group||addgroup "$group";done
for pair in "management:$MANAGEMENT_USERS" "engineering:$ENGINEERING_USERS" "sales:$SALES_USERS" "support:$SUPPORT_USERS";do group=${pair%%:*};users=${pair#*:};for user in $users;do grep -q "^${user}:" /etc/passwd||adduser -D -H -G "$group" -s /bin/sh "$user";done;done
for n in 1 2 3 4 5 6 7 8 9 10;do account=level$n;grep -q "^${account}:" /etc/passwd||adduser -D -h "/home/$account" -s /bin/sh "$account";usermod -aG sysadmin "$account";rm -rf "/home/$account"/* "/home/$account"/.[!.]* "/home/$account"/..?* 2>/dev/null||true;cp /root/.profile "/home/$account/.profile";cp /root/validate "/home/$account/validate";chown "$account:$account" "/home/$account" "/home/$account/.profile" "/home/$account/validate";chmod 700 "/home/$account" "/home/$account/validate";chmod 600 "/home/$account/.profile";done
cat >/etc/sudoers.d/polylinux-permissions <<'SUDOERS'
%sysadmin ALL=(ALL:ALL) NOPASSWD: ALL
SUDOERS
chown root:root /etc/sudoers.d/polylinux-permissions;chmod 440 /etc/sudoers.d/polylinux-permissions
if command -v visudo >/dev/null 2>&1;then visudo -cf /etc/sudoers.d/polylinux-permissions >/dev/null;fi
for n in 1 2 3 4 5 6 7 8 9 10;do id -nG level$n|grep -qw sysadmin||{ echo "level$n is not in sysadmin" >&2;exit 1;};done
build_level(){ LEVEL_NUMBER=$1;levelToBuild=level$1;newPass=$LEVEL_PASSWORD_PREFIX$1;level_HASH=$(printf '%s' "$USER_ID$EXERCISE_CODE$SYSTEM_PASSWORD$newPass"|sha256sum|awk '{print $1}');export LEVEL_NUMBER levelToBuild newPass level_HASH;sh "/root/level$1.sh";}
echo "Exercise code: $EXERCISE_CODE"
# Build synchronously so every level is ready before navigation begins.
for n in 1 2 3 4 5 6 7 8 9 10;do echo "Building level $n...";build_level "$n";done
echo "All levels are ready."
exec su - level1
