#!/bin/sh
set -eu
mkdir -p /home
DATE=$(date +%Y%m%d)
EXERCISE_CODE=$(printf '%X
' "$DATE")
echo "Exercise code: $EXERCISE_CODE"
echo "Enter email:"; read USER_ID
for n in 1 2 3 4 5 6 7 8 9 10; do
 adduser -D -h /home/level$n -s /bin/sh level$n 2>/dev/null || true
 echo "level$n ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
 cp /root/level$n.sh /home/level$n/
done
sh /root/level1.sh
for n in 2 3 4 5 6 7 8 9 10; do sh /root/level$n.sh >/tmp/level$n.log 2>&1 & done
su - level1
