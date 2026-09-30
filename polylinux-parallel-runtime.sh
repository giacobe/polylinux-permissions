#!/bin/sh
MAX_PARALLEL=${MAX_PARALLEL:-10}
STATUS_ROOT=${STATUS_ROOT:-/run/polylinux/$LAB_ID}
READY_DIR=$STATUS_ROOT/ready
FAILED_DIR=$STATUS_ROOT/failed
BUILD_LOG=${BUILD_LOG:-/var/log/$LAB_ID-build.log}
HOME_ROOT=${HOME_ROOT:-/home}
export STATUS_ROOT READY_DIR FAILED_DIR BUILD_LOG HOME_ROOT

write_pending_readme() {
    home=$1
    mkdir -p "$home"
    printf '%s\n' 'This level has not completed building yet.' 'You may continue to another level or return here shortly.' > "$home/README.txt"
}

write_failed_readme() {
    home=$1
    level=$2
    printf 'Level %s could not be prepared. Restart the lab.\n' "$level" > "$home/README.txt"
}

prepare_standard_accounts() {
    mkdir -p "$HOME_ROOT" "$READY_DIR" "$FAILED_DIR"
    chmod 755 "$STATUS_ROOT" "$READY_DIR" "$FAILED_DIR"
    : > "$BUILD_LOG"
    levelnumber=1
    while [ "$levelnumber" -le 10 ]
    do
        levelToBuild="level$levelnumber"
        final_home="$HOME_ROOT/$levelToBuild"
        if ! id "$levelToBuild" >/dev/null 2>&1; then
            adduser -D -g "$LAB_TITLE learner" "$levelToBuild"
        fi
        passwd -d "$levelToBuild" >/dev/null 2>&1 || true
        usermod -aG sysadmin "$levelToBuild"
        rm -rf "$final_home"
        mkdir -p "$final_home"
        cp "$INSTALL_ROOT/profile" "$final_home/.profile"
        cp "$INSTALL_ROOT/validate" "$final_home/validate"
        write_pending_readme "$final_home"
        chown "$levelToBuild:$levelToBuild" "$final_home" "$final_home/.profile" "$final_home/validate" "$final_home/README.txt"
        chmod 700 "$final_home" "$final_home/validate"
        chmod 600 "$final_home/.profile"
        rm -f "$READY_DIR/$levelToBuild" "$FAILED_DIR/$levelToBuild"
        levelnumber=$((levelnumber + 1))
    done
}

build_standard_level() (
    levelnumber=$1
    levelToBuild="level$levelnumber"
    final_home="$HOME_ROOT/$levelToBuild"
    LEVEL_HOME="$HOME_ROOT/.polylinux-build-$LAB_ID-$levelToBuild"
    readMeLocation="$LEVEL_HOME/.README.generated"
    levelPassword="${LEVEL_PASSWORD_ROOT}${levelnumber}"
    level_HASH=$(level_seed_v1)
    export levelnumber levelToBuild LEVEL_HOME readMeLocation levelPassword level_HASH

    rm -rf "$LEVEL_HOME"
    mkdir -p "$LEVEL_HOME"

    if sh "$INSTALL_ROOT/level$levelnumber.sh"; then
        [ -s "$readMeLocation" ] || {
            printf 'Level %s produced no README instructions.\n' "$levelnumber" >&2
            exit 1
        }
        final_readme="$LEVEL_HOME/README.txt"
        render_level_readme "$readMeLocation" "$final_readme"
        rm -f "$readMeLocation"
        cp "$INSTALL_ROOT/profile" "$LEVEL_HOME/.profile"
        cp "$INSTALL_ROOT/validate" "$LEVEL_HOME/validate"

        rm -rf "$final_home"
        mv "$LEVEL_HOME" "$final_home"

        # Preserve exercise ownership and modes. Only level-owned control files
        # and the home directory itself are reassigned here.
        chown "$levelToBuild:$levelToBuild" "$final_home" "$final_home/.profile" "$final_home/validate" "$final_home/README.txt"
        chmod 700 "$final_home" "$final_home/validate"
        chmod 600 "$final_home/.profile"
        chmod 400 "$final_home/README.txt"
        touch "$READY_DIR/$levelToBuild"
        printf '%s ready\n' "$levelToBuild"
        exit 0
    fi

    rm -rf "$LEVEL_HOME"
    mkdir -p "$final_home"
    write_failed_readme "$final_home" "$levelToBuild"
    chown "$levelToBuild:$levelToBuild" "$final_home" "$final_home/README.txt"
    touch "$FAILED_DIR/$levelToBuild"
    printf '%s failed\n' "$levelToBuild" >&2
    exit 1
)

build_standard_levels() {
    failures=0
    pids=
    levelnumber=1
    while [ "$levelnumber" -le 10 ]
    do
        build_standard_level "$levelnumber" >> "$BUILD_LOG" 2>&1 &
        pids="$pids $!"
        levelnumber=$((levelnumber + 1))
    done
    for pid in $pids
    do
        wait "$pid" || failures=$((failures + 1))
    done
    if [ "$failures" -eq 0 ]; then
        touch "$STATUS_ROOT/all-ready"
        return 0
    fi
    touch "$STATUS_ROOT/build-failed"
    printf '%s level builds failed\n' "$failures" >> "$BUILD_LOG"
    return 1
}

start_standard_levels() {
    printf 'Preparing 10 %s levels.\n' "$LAB_TITLE"
    (trap '' HUP; build_standard_levels) < /dev/null &
    while [ ! -f "$READY_DIR/level1" ]
    do
        [ ! -f "$FAILED_DIR/level1" ] || poly_die "level1 failed; see $BUILD_LOG"
        sleep 1
    done
    printf 'Level 1 is ready; later levels may still be preparing.\n'
    exec su -l level1
}
