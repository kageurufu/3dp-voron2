#!/bin/bash

git_version() {
	git rev-parse --short=7 HEAD
}

get_git_version() {
	pushd "$1" >&2
	git_version
	popd       >&2
}

build_message() {
	KLIPPER_VERSION="$(get_git_version "$HOME/klipper")"
	MOONRAKER_VERSION="$(get_git_version "$HOME/moonraker")"
	MAINSAIL_VERSION="$(head -n 1 "$HOME/mainsail/.version")"
	TIMELAPSE_VERSION="$(get_git_version "$HOME/moonraker-timelapse")"
	KLIPPERSCREEN_VERSION="$(get_git_version "$HOME/klipperscreen")"
	ZCALIBRATE_VERSION="$(get_git_version "$HOME/klipper_z_calibration")"
	CROWSNEST_VERSION="$(get_git_version "$HOME/crowsnest")"

	KLIPPER_PYTHON="$($HOME/klippy-env/bin/python -V)"
	MOONRAKER_PYTHON="$($HOME/moonraker-env/bin/python -V)"
	KLIPPER_DEPS="$($HOME/klippy-env/bin/pip freeze | sed 's/^/    /')"
	MOONRAKER_DEPS="$($HOME/moonraker-env/bin/pip freeze | sed 's/^/    /')"
	
	echo "Voron V2.1112 Starting $(date +'%x at %X')"
	echo ""
	echo "Klipper:             $KLIPPER_VERSION"
	echo "Auto Calibrate Z:    $ZCALIBRATE_VERSION"
	echo "Moonraker:           $MOONRAKER_VERSION"
	echo "Moonraker Timelapse: $TIMELAPSE_VERSION"
	echo "KlipperScreen:       $KLIPPERSCREEN_VERSION"
	echo "CrowsNest:           $CROWSNEST_VERSION"
	echo ""
	echo "klippy-env: $KLIPPER_PYTHON"
	echo "$KLIPPER_DEPS"
	echo ""
	echo "moonraker-env: $MOONRAKER_PYTHON"
	echo "$MOONRAKER_DEPS"
}

cd "$HOME"
GIT_MESSAGE="$(build_message 2>/dev/null)"
git add .
git commit -m "$GIT_MESSAGE"
git push
