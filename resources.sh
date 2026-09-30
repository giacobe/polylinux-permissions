#!/bin/sh
. "$INSTALL_ROOT/company-data.sh"
word_at() { list=$1; wanted=$2; i=0; for item in $list; do [ "$i" -eq "$wanted" ] && { printf '%s\n' "$item"; return 0; }; i=$((i + 1)); done; return 1; }
hex_value() { case "$1" in 0)echo 0;;1)echo 1;;2)echo 2;;3)echo 3;;4)echo 4;;5)echo 5;;6)echo 6;;7)echo 7;;8)echo 8;;9)echo 9;;a|A)echo 10;;b|B)echo 11;;c|C)echo 12;;d|D)echo 13;;e|E)echo 14;;f|F)echo 15;;*)return 1;;esac; }
hash_index() { digit=$(printf '%s' "$level_HASH" | cut -c "$1"); value=$(hex_value "$digit") || return 1; echo $((value % $2)); }
department_users() { case "$1" in management)echo "$MANAGEMENT_USERS";;engineering)echo "$ENGINEERING_USERS";;sales)echo "$SALES_USERS";;support)echo "$SUPPORT_USERS";;*)return 1;;esac; }
derive_parameters() {
    department_index=$(hash_index 1 4)
    user_index=$(hash_index 2 6)
    project_index=$(hash_index 3 4)
    document_index=$(hash_index 4 4)
    variant=$(hash_index 5 4)
    DEPARTMENT=$(word_at "$DEPARTMENTS" "$department_index")
    department_user_list=$(department_users "$DEPARTMENT")
    TARGET_USER=$(word_at "$department_user_list" "$user_index")
    PROJECT=$(word_at "$PROJECTS" "$project_index")
    DOCUMENT=$(word_at "$DOCUMENTS" "$document_index")
    WRONG_DEPARTMENT=$(word_at "$DEPARTMENTS" $(((department_index + 1) % 4)))
    export DEPARTMENT TARGET_USER PROJECT DOCUMENT WRONG_DEPARTMENT variant
}
finish_level() { :; }
