#!/bin/sh
SEED_CONTRACT_VERSION=seed-v1
export SEED_CONTRACT_VERSION
poly_die() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }
command_required() { command -v "$1" >/dev/null 2>&1 || poly_die "required command not found: $1"; }
normalize_email() { printf '%s' "$1" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]'; }
validate_email() { case "$1" in ?*@?*.*) return 0 ;; *) return 1 ;; esac; }
validate_iso_date() { case "$1" in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) return 0 ;; *) return 1 ;; esac; }
exercise_code_from_date() { decimal=$(printf '%s' "$1" | tr -d '-'); printf '%X\n' "$decimal"; }
level_seed_v1() {
    printf '%s\0%s\0%s\0%s\0%s\0%s\0%s\0' \
        'polylinux-seed-v1' "$LAB_ID" "$USER_ID" "$currentDate" \
        "$SYSTEM_PASSWORD" "$levelPassword" "$levelnumber" |
        sha256sum | awk '{print $1}'
}
format_block() {
    input=$1
    divider='************************************************************************'
    printf '%s\n' "$divider"
    printf '%s\n' "$input" | fold -s -w 68 | while IFS= read -r line
    do
        printf '* %-68s *\n' "$line"
    done
    printf '%s\n' "$divider"
}
render_level_readme() {
    generated=$1
    output=$2
    {
        echo '************************************************************************'
        printf '* %-68s *\n' "Level: $levelToBuild"
        printf '* %-68s *\n' "PolyLinux: $LAB_TITLE"
        printf '* %-68s *\n' "Participant: $USER_ID"
        printf '* %-68s *\n' "Exercise code: $EXERCISE_CODE"
        echo '************************************************************************'
        cat "$generated"
    } > "$output"
}
