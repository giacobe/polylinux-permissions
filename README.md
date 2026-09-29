# PolyLinux Permissions Lab v3

Extract all files, including `.profile`, directly into `/root`, then run `/root/install.sh` as root.

This revision:

- uses real sudo and verified sysadmin membership;
- builds all ten levels synchronously, so `nextlevel` cannot wait on a failed background builder;
- installs `validate` globally and copies it into every level home so both `validate` and `./validate` work from the home directory;
- emits a 20-character Base64 validation code rather than the raw SHA-256 hash;
- uses a complete, syntax-checked `.profile`;
- uses passwordless sudo navigation between level accounts.
