#!/bin/sh
set -eu
for file in install.sh resources.sh company-data.sh profile .profile nextlevel prevlevel validate level1.sh level2.sh level3.sh level4.sh level5.sh level6.sh level7.sh level8.sh level9.sh level10.sh
do
    [ -f "$file" ]
    sh -n "$file"
done
[ -x install.sh ]
[ -x validate ]
[ -x nextlevel ]
[ -x prevlevel ]
grep -q 'Validation code:' validate
grep -q 'cut -c 1-20' validate
echo "Static checks passed."
