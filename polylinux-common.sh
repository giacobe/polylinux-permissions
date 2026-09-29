#!/bin/sh
SEED_CONTRACT_VERSION=seed-v1
export SEED_CONTRACT_VERSION
poly_die(){ printf 'ERROR: %s\n' "$*" >&2; exit 1; }
command_required(){ command -v "$1" >/dev/null 2>&1 || poly_die "required command not found: $1"; }
normalize_email(){ printf '%s' "$1" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]'; }
validate_email(){ case "$1" in ?*@?*.*) return 0;; *) return 1;; esac; }
validate_iso_date(){ case "$1" in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) return 0;; *) return 1;; esac; }
exercise_code_from_date(){ decimal=$(printf '%s' "$1"|tr -d '-'); printf '%X\n' "$decimal"; }
level_seed_v1(){ printf '%s\0%s\0%s\0%s\0%s\0%s\0%s\0' 'polylinux-seed-v1' "$LAB_ID" "$USER_ID" "$currentDate" "$SYSTEM_PASSWORD" "$levelPassword" "$levelnumber" | sha256sum | awk '{print $1}'; }
format_block(){ printf '%s\n' "$1" | fold -s -w 70; }
