#!/bin/sh
set -eu
for file in .profile profile install.sh company-data.sh resources.sh polylinux-common.sh polylinux-parallel-runtime.sh nextlevel prevlevel validate level1.sh level2.sh level3.sh level4.sh level5.sh level6.sh level7.sh level8.sh level9.sh level10.sh
do
    [ -f "$file" ]
    sh -n "$file"
done
for level in 1 2 3 4 5 6 7 8 9 10
do
    grep -F 'format_block "$levelinstructions" >> "$readMeLocation"' "level$level.sh" >/dev/null
    grep -F 'Run validate when finished' "level$level.sh" >/dev/null
done
grep -F '[ -s "$readMeLocation" ]' polylinux-parallel-runtime.sh >/dev/null
grep -F 'render_level_readme "$readMeLocation" "$final_readme"' polylinux-parallel-runtime.sh >/dev/null
grep -F './install.sh' .profile >/dev/null
grep -F 'cp "$INSTALL_ROOT/profile" "$final_home/.profile"' polylinux-parallel-runtime.sh >/dev/null
fixture=$(mktemp -d)
trap 'rm -rf "$fixture"' EXIT HUP INT TERM
mkdir "$fixture/data"
echo fixture > "$fixture/data/item.txt"
key=$(POLYLINUX_VALIDATE_HOME="$fixture" USER=level1 sh ./validate | awk '{print $4}')
case "$key" in ??????????) : ;; *) echo "invalid key: $key" >&2; exit 1 ;; esac
echo 'README pipeline, shell syntax, profiles, and validator checks passed.'
