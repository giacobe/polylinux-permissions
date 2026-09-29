#!/bin/sh
STATUS_ROOT=${STATUS_ROOT:-/run/polylinux/$LAB_ID}
READY_DIR=$STATUS_ROOT/ready
FAILED_DIR=$STATUS_ROOT/failed
BUILD_LOG=${BUILD_LOG:-/var/log/$LAB_ID-build.log}
HOME_ROOT=${HOME_ROOT:-/home}
export STATUS_ROOT READY_DIR FAILED_DIR BUILD_LOG HOME_ROOT
write_pending_readme(){ home=$1; mkdir -p "$home"; printf '%s\n' 'This level has not completed building yet.' 'Use nextlevel or prevlevel, or return shortly.' > "$home/README.txt"; }
write_failed_readme(){ home=$1; level=$2; printf 'Level %s could not be prepared. Restart the lab.\n' "$level" > "$home/README.txt"; }
prepare_standard_accounts(){
 mkdir -p "$HOME_ROOT" "$READY_DIR" "$FAILED_DIR";chmod 755 "$STATUS_ROOT" "$READY_DIR" "$FAILED_DIR";: > "$BUILD_LOG"
 n=1;while [ "$n" -le 10 ];do u=level$n;id "$u" >/dev/null 2>&1||adduser -D -g "$LAB_TITLE learner" "$u";passwd -d "$u" >/dev/null 2>&1||true;usermod -aG sysadmin "$u";home=$HOME_ROOT/$u;rm -rf "$home";mkdir -p "$home";cp "$INSTALL_ROOT/profile" "$home/.profile";cp "$INSTALL_ROOT/validate" "$home/validate";write_pending_readme "$home";chown -R "$u:$u" "$home";chmod 700 "$home";chmod 700 "$home/validate";rm -f "$READY_DIR/$u" "$FAILED_DIR/$u";n=$((n+1));done
}
build_standard_level(){
 n=$1;u=level$n;home=$HOME_ROOT/$u;stage=$HOME_ROOT/.polylinux-build-$LAB_ID-$u;rm -rf "$stage";mkdir -p "$stage";LEVEL_HOME=$stage;readMeLocation=$stage/README.txt;levelnumber=$n;levelToBuild=$u;levelPassword=$LEVEL_PASSWORD_ROOT$n;level_HASH=$(level_seed_v1);export LEVEL_HOME readMeLocation levelnumber levelToBuild levelPassword level_HASH
 if sh "$INSTALL_ROOT/level$n.sh";then cp "$INSTALL_ROOT/profile" "$stage/.profile";cp "$INSTALL_ROOT/validate" "$stage/validate";rm -rf "$home";mv "$stage" "$home";chown -R "$u:$u" "$home";chmod 700 "$home" "$home/validate";touch "$READY_DIR/$u";printf '%s ready\n' "$u";else rm -rf "$stage";write_failed_readme "$home" "$u";chown -R "$u:$u" "$home";touch "$FAILED_DIR/$u";return 1;fi
}
build_standard_levels(){ failures=0;n=1;while [ "$n" -le 10 ];do build_standard_level "$n" >>"$BUILD_LOG" 2>&1 & eval "pid$n=$!";n=$((n+1));done;n=1;while [ "$n" -le 10 ];do eval "pid=\$pid$n";wait "$pid"||failures=$((failures+1));n=$((n+1));done;[ "$failures" -eq 0 ]&&touch "$STATUS_ROOT/all-ready"||touch "$STATUS_ROOT/build-failed"; }
start_standard_levels(){ printf 'Preparing 10 %s levels.\n' "$LAB_TITLE";(trap '' HUP;build_standard_levels </dev/null)&while [ ! -f "$READY_DIR/level1" ];do [ ! -f "$FAILED_DIR/level1" ]||poly_die "level1 failed; see $BUILD_LOG";sleep 1;done;printf 'Level 1 is ready; later levels may still be preparing.\n';exec su -l level1; }
