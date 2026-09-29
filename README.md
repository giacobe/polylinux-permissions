# PolyLinux Users, Groups, and Permissions

This package follows the PolyLinux File Manipulation runtime contract:

- `/root/.profile` is the one-time root bootstrap and runs `./install.sh`.
- `/root/profile` is copied to each level account as `.profile`.
- Level 1 becomes available first; remaining levels build concurrently.
- `nextlevel` and `prevlevel` use the standard level-account navigation pattern.
- `validate` fingerprints the current level home and prints an exact 10-character Base64 key without reporting correctness.
- Real sudo is used for ownership, group, and permission administration.
