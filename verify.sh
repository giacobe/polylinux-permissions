#!/bin/sh
set -eu
for f in .profile profile install.sh company-data.sh resources.sh polylinux-common.sh polylinux-parallel-runtime.sh nextlevel prevlevel validate level1.sh level2.sh level3.sh level4.sh level5.sh level6.sh level7.sh level8.sh level9.sh level10.sh;do [ -f "$f" ];sh -n "$f";done
case $(POLYLINUX_VALIDATE_HOME=$(mktemp -d) USER=level1 sh ./validate|awk '{print $4}') in ??????????) :;;*) exit 1;;esac
grep -F './install.sh' .profile >/dev/null
grep -F 'cp "$INSTALL_ROOT/profile" "$home/.profile"' polylinux-parallel-runtime.sh >/dev/null
echo 'Contract and syntax checks passed.'
