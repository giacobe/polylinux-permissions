#!/bin/sh
SYSTEM_PASSWORD="CHANGE-ME-PERMISSIONS-SYSTEM-PASSWORD"
LEVEL_PASSWORD_PREFIX="permissions-level-"
. /root/company-data.sh
word_at(){ list=$1;wanted=$2;i=0;for item in $list;do [ "$i" -eq "$wanted" ]&&{ printf '%s\n' "$item";return 0;};i=$((i+1));done;return 1;}
hex_value(){ case "$1" in 0)echo 0;;1)echo 1;;2)echo 2;;3)echo 3;;4)echo 4;;5)echo 5;;6)echo 6;;7)echo 7;;8)echo 8;;9)echo 9;;a|A)echo 10;;b|B)echo 11;;c|C)echo 12;;d|D)echo 13;;e|E)echo 14;;f|F)echo 15;;*)return 1;;esac;}
hash_index(){ d=$(printf '%s' "$level_HASH"|cut -c "$1");v=$(hex_value "$d")||return 1;echo $((v%$2));}
department_users(){ case "$1" in management)echo "$MANAGEMENT_USERS";;engineering)echo "$ENGINEERING_USERS";;sales)echo "$SALES_USERS";;support)echo "$SUPPORT_USERS";;*)return 1;;esac;}
derive_level_parameters(){ di=$(hash_index 1 4);ui=$(hash_index 2 6);pi=$(hash_index 3 4);fi=$(hash_index 4 4);variant=$(hash_index 5 4);DEPARTMENT=$(word_at "$DEPARTMENTS" "$di");du=$(department_users "$DEPARTMENT");TARGET_USER=$(word_at "$du" "$ui");PROJECT=$(word_at "$PROJECTS" "$pi");DOCUMENT=$(word_at "$DOCUMENTS" "$fi");WRONG_DEPARTMENT=$(word_at "$DEPARTMENTS" $(((di+1)%4)));export DEPARTMENT TARGET_USER PROJECT DOCUMENT WRONG_DEPARTMENT variant;}
begin_level(){ LEVEL_HOME=/home/$levelToBuild;LEVEL_WORK=$LEVEL_HOME/company;rm -rf "$LEVEL_WORK";mkdir -p "$LEVEL_WORK";chown "$levelToBuild:$levelToBuild" "$LEVEL_HOME" "$LEVEL_WORK";chmod 700 "$LEVEL_HOME";chmod 755 "$LEVEL_WORK";README_BUILD=$LEVEL_HOME/.README.txt.building;{ echo 'PolyLinux Users, Groups, and Permissions';echo "Level: $LEVEL_NUMBER";echo "Participant: $USER_ID";echo "Exercise code: $EXERCISE_CODE";echo;echo 'Use the current level account for investigation.';echo 'Use sudo only when the requested change requires elevated privileges.';echo 'Change only the objects identified by the instructions.';echo;echo TASK;} > "$README_BUILD";}
finish_level(){ mv "$README_BUILD" "$LEVEL_HOME/README.txt";chown "$levelToBuild:$levelToBuild" "$LEVEL_HOME/README.txt" "$LEVEL_HOME/.profile";chmod 400 "$LEVEL_HOME/README.txt";}
