#!/bin/sh

SYSTEM_PASSWORD="CHANGE-ME-PERMISSIONS-SYSTEM-PASSWORD"
LEVEL_PASSWORD_PREFIX="permissions-level-"

. /root/company-data.sh

word_at() {
    list=$1
    wanted=$2
    current=0

    for item in $list
    do
        if [ "$current" -eq "$wanted" ]; then
            printf '%s\n' "$item"
            return 0
        fi
        current=$((current + 1))
    done

    return 1
}

hex_value() {
    case "$1" in
        0) echo 0 ;; 1) echo 1 ;; 2) echo 2 ;; 3) echo 3 ;;
        4) echo 4 ;; 5) echo 5 ;; 6) echo 6 ;; 7) echo 7 ;;
        8) echo 8 ;; 9) echo 9 ;; a|A) echo 10 ;; b|B) echo 11 ;;
        c|C) echo 12 ;; d|D) echo 13 ;; e|E) echo 14 ;; f|F) echo 15 ;;
        *) return 1 ;;
    esac
}

hash_index() {
    position=$1
    modulus=$2
    digit=$(printf '%s' "$level_HASH" | cut -c "$position")
    value=$(hex_value "$digit") || return 1
    echo $((value % modulus))
}

department_users() {
    case "$1" in
        management) printf '%s\n' "$MANAGEMENT_USERS" ;;
        engineering) printf '%s\n' "$ENGINEERING_USERS" ;;
        sales) printf '%s\n' "$SALES_USERS" ;;
        support) printf '%s\n' "$SUPPORT_USERS" ;;
        *) return 1 ;;
    esac
}

derive_level_parameters() {
    department_index=$(hash_index 1 4)
    user_index=$(hash_index 2 6)
    project_index=$(hash_index 3 4)
    document_index=$(hash_index 4 4)
    variant=$(hash_index 5 4)

    DEPARTMENT=$(word_at "$DEPARTMENTS" "$department_index")
    DEPARTMENT_USERS=$(department_users "$DEPARTMENT")
    TARGET_USER=$(word_at "$DEPARTMENT_USERS" "$user_index")
    PROJECT=$(word_at "$PROJECTS" "$project_index")
    DOCUMENT=$(word_at "$DOCUMENTS" "$document_index")
    WRONG_DEPARTMENT=$(word_at "$DEPARTMENTS" $(((department_index + 1) % 4)))

    export DEPARTMENT TARGET_USER PROJECT DOCUMENT WRONG_DEPARTMENT variant
}

begin_level() {
    LEVEL_HOME="/home/$levelToBuild"
    LEVEL_WORK="$LEVEL_HOME/company"

    rm -rf "$LEVEL_WORK"
    mkdir -p "$LEVEL_WORK"
    chown "$levelToBuild:$levelToBuild" "$LEVEL_HOME" "$LEVEL_WORK"
    chmod 700 "$LEVEL_HOME"
    chmod 755 "$LEVEL_WORK"

    README_BUILD="$LEVEL_HOME/.README.txt.building"
    {
        printf '%s\n' "PolyLinux Users, Groups, and Permissions"
        printf '%s\n' "Level: $LEVEL_NUMBER"
        printf '%s\n' "Participant: $USER_ID"
        printf '%s\n' "Exercise code: $EXERCISE_CODE"
        printf '%s\n' ""
        printf '%s\n' "Use the current level account for investigation."
        printf '%s\n' "Use sudo only when the requested change requires elevated privileges."
        printf '%s\n' "Change only the objects identified by the instructions."
        printf '%s\n' ""
        printf '%s\n' "TASK"
    } > "$README_BUILD"
}

finish_level() {
    mv "$README_BUILD" "$LEVEL_HOME/README.txt"
    chown "$levelToBuild:$levelToBuild" "$LEVEL_HOME/README.txt" "$LEVEL_HOME/.profile"
    chmod 400 "$LEVEL_HOME/README.txt"
}
