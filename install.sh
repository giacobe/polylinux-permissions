#!/bin/sh
set -eu
[ "$(id -u)" -eq 0 ]||{ echo 'Run /root/install.sh as root.' >&2;exit 1;}
cd /root
required="company-data.sh resources.sh profile .profile nextlevel prevlevel validate"
for n in 1 2 3 4 5 6 7 8 9 10;do required="$required level$n.sh";done
for f in $required;do [ -f /root/$f ]||{ echo "Missing required file: /root/$f" >&2;exit 1;};done
command -v sudo >/dev/null 2>&1||{ echo 'sudo is not installed.' >&2;exit 1;}
command -v usermod >/dev/null 2>&1||{ echo 'usermod is not installed.' >&2;exit 1;}
mkdir -p /home /usr/local/bin /etc/sudoers.d
cp /root/profile /etc/profile
cp /root/nextlevel /root/prevlevel /root/validate /usr/local/bin/
chmod 755 /usr/local/bin/nextlevel /usr/local/bin/prevlevel /usr/local/bin/validate /root/*.sh /root/profile /root/.profile
D=$(date +%Y%m%d);EXERCISE_CODE=$(printf '%X\n' "$D");export EXERCISE_CODE
confirmed=n
while [ "$confirmed" != y ]&&[ "$confirmed" != Y ];do printf 'Enter your email address: ';IFS= read -r USER_ID;echo "You entered: $USER_ID";printf 'Is this correct? (y/n): ';IFS= read -r confirmed;done
export USER_ID
. /root/company-data.sh
. /root/resources.sh
for g in $DEPARTMENTS sysadmin;do grep -q "^$g:" /etc/group||addgroup "$g";done
for pair in "management:$MANAGEMENT_USERS" "engineering:$ENGINEERING_USERS" "sales:$SALES_USERS" "support:$SUPPORT_USERS";do g=${pair%%:*};users=${pair#*:};for u in $users;do grep -q "^$u:" /etc/passwd||adduser -D -H -G "$g" -s /bin/sh "$u";done;done
for n in 1 2 3 4 5 6 7 8 9 10;do account=level$n;grep -q "^$account:" /etc/passwd||adduser -D -h /home/$account -s /bin/sh "$account";usermod -aG sysadmin "$account";rm -rf /home/$account/* /home/$account/.[!.]* /home/$account/..?* 2>/dev/null||true;cp /root/.profile /home/$account/.profile;chown "$account:$account" /home/$account /home/$account/.profile;chmod 700 /home/$account;chmod 600 /home/$account/.profile;done
cat >/etc/sudoers.d/polylinux-permissions <<'SUDOERS'
%sysadmin ALL=(ALL:ALL) NOPASSWD: ALL
SUDOERS
chown root:root /etc/sudoers.d/polylinux-permissions;chmod 440 /etc/sudoers.d/polylinux-permissions
command -v visudo >/dev/null 2>&1&&visudo -cf /etc/sudoers.d/polylinux-permissions >/dev/null
for n in 1 2 3 4 5 6 7 8 9 10;do id -nG level$n|grep -qw sysadmin||{ echo "Failed to add level$n to sysadmin." >&2;exit 1;};done
build(){ LEVEL_NUMBER=$1;levelToBuild=level$1;newPass=$LEVEL_PASSWORD_PREFIX$1;level_HASH=$(printf '%s' "$USER_ID$EXERCISE_CODE$SYSTEM_PASSWORD$newPass"|sha256sum|awk '{print $1}');export LEVEL_NUMBER levelToBuild newPass level_HASH;sh /root/level$1.sh;}
echo "Exercise code: $EXERCISE_CODE";echo 'Building level 1...';build 1;echo 'Level 1 is ready.'
for n in 2 3 4 5 6 7 8 9 10;do (build "$n")>/tmp/permissions-level$n.log 2>&1&done
echo 'Levels 2 through 10 are building in parallel.'
exec su - level1
