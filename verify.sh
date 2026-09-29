#!/bin/sh
set -eu

for file in install.sh resources.sh company-data.sh profile .profile nextlevel prevlevel validate level1.sh level2.sh level3.sh level4.sh level5.sh level6.sh level7.sh level8.sh level9.sh level10.sh
do
    [ -f "$file" ] || {
        echo "Missing: $file" >&2
        exit 1
    }
    sh -n "$file"
done

echo "All required files are present and pass shell syntax validation."
