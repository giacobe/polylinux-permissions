# PolyLinux Users, Groups, and Permissions

This build uses the File Manipulation README pipeline exactly:

1. The runtime creates a private staging home for each level.
2. The runtime sets `readMeLocation` to a generated README fragment.
3. The level script appends `format_block "$levelinstructions"` to that file.
4. The runtime rejects an empty README fragment.
5. The runtime prepends level, lab, participant, and exercise-code metadata.
6. The completed README and staged filesystem are published atomically to `/home/levelN`.

`/root/.profile` runs the installer once, while `/root/profile` is copied to every level account as `.profile`.
