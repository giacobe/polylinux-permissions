# PolyLinux Permissions Lab

Extract every file, including `.profile`, directly into `/root`, then run `/root/install.sh` as root. This revision uses `usermod -aG sysadmin` and verifies every level account's group membership before starting. Navigation uses passwordless `sudo -u levelN -i`, so level account passwords are not deleted.
