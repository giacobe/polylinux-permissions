#!/bin/sh

set -eu

[ "$(id -u)" -eq 0 ] || {
    echo "Run /root/install.sh as root." >&2
    exit 1
}

cd /root

required_files="company-data.sh resources.sh profile .profile nextlevel prevlevel validate"
for number in 1 2 3 4 5 6 7 8 9 10
do
    required_files="$required_files level$number.sh"
done

for file in $required_files
do
    [ -f "/root/$file" ] || {
        echo "Missing required file: /root/$file" >&2
        exit 1
    }
done

command -v sudo >/dev/null 2>&1 || {
    echo "sudo is not installed in this Buildroot image." >&2
    exit 1
}

mkdir -p /home /usr/local/bin /etc/sudoers.d
cp /root/profile /etc/profile
cp /root/nextlevel /root/prevlevel /root/validate /usr/local/bin/
chmod 755 /usr/local/bin/nextlevel /usr/local/bin/prevlevel /usr/local/bin/validate
chmod 755 /root/*.sh /root/profile /root/.profile

DATE_DECIMAL=$(date +%Y%m%d)
EXERCISE_CODE=$(printf '%X\n' "$DATE_DECIMAL")
export EXERCISE_CODE

confirmed=n
while [ "$confirmed" != y ] && [ "$confirmed" != Y ]
do
    printf '%s' "Enter your email address: "
    IFS= read -r USER_ID
    printf '%s\n' "You entered: $USER_ID"
    printf '%s' "Is this correct? (y/n): "
    IFS= read -r confirmed
done
export USER_ID

. /root/company-data.sh
. /root/resources.sh

for group in $DEPARTMENTS sysadmin
do
    grep -q "^${group}:" /etc/group || addgroup "$group"
done

for user in $MANAGEMENT_USERS
do
    grep -q "^${user}:" /etc/passwd || adduser -D -H -G management -s /bin/sh "$user"
done
for user in $ENGINEERING_USERS
do
    grep -q "^${user}:" /etc/passwd || adduser -D -H -G engineering -s /bin/sh "$user"
done
for user in $SALES_USERS
do
    grep -q "^${user}:" /etc/passwd || adduser -D -H -G sales -s /bin/sh "$user"
done
for user in $SUPPORT_USERS
do
    grep -q "^${user}:" /etc/passwd || adduser -D -H -G support -s /bin/sh "$user"
done

for number in 1 2 3 4 5 6 7 8 9 10
do
    account="level$number"
    grep -q "^${account}:" /etc/passwd || adduser -D -h "/home/$account" -s /bin/sh "$account"
    adduser "$account" sysadmin >/dev/null 2>&1 || true
    passwd -d "$account" >/dev/null 2>&1 || true
    rm -rf "/home/$account"/* "/home/$account"/.[!.]* "/home/$account"/..?* 2>/dev/null || true
    cp /root/.profile "/home/$account/.profile"
    chown "$account:$account" "/home/$account" "/home/$account/.profile"
    chmod 700 "/home/$account"
    chmod 600 "/home/$account/.profile"
done

cat > /etc/sudoers.d/polylinux-permissions <<'SUDOERS'
%sysadmin ALL=(ALL) NOPASSWD: ALL
SUDOERS
chown root:root /etc/sudoers.d/polylinux-permissions
chmod 440 /etc/sudoers.d/polylinux-permissions

if command -v visudo >/dev/null 2>&1
then
    visudo -cf /etc/sudoers.d/polylinux-permissions >/dev/null
fi

build_level() {
    LEVEL_NUMBER=$1
    levelToBuild="level$LEVEL_NUMBER"
    newPass="${LEVEL_PASSWORD_PREFIX}${LEVEL_NUMBER}"
    level_HASH=$(printf '%s' "$USER_ID$EXERCISE_CODE$SYSTEM_PASSWORD$newPass" | sha256sum | awk '{print $1}')
    export LEVEL_NUMBER levelToBuild newPass level_HASH
    sh "/root/level$LEVEL_NUMBER.sh"
}

echo "Exercise code: $EXERCISE_CODE"
echo "Building level 1..."
build_level 1
echo "Level 1 is ready."

for number in 2 3 4 5 6 7 8 9 10
do
    (
        build_level "$number"
    ) > "/tmp/permissions-level$number.log" 2>&1 &
done

echo "Levels 2 through 10 are building in parallel."
exec su - level1
