#!/usr/bin/env bash
#
# lib.sh: shared helpers. Source it from the other scripts; do not run it.
#
# It loads the machine config, sets the LeRobot arm types, and defines `run`.
# Set DRY_RUN=1 to print each command instead of running it. Set ARM_CONFIG to
# use a config file other than config/machine.env.

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
config_file="${ARM_CONFIG:-$repo_root/config/machine.env}"

if [[ ! -f "$config_file" ]]; then
  echo "error: no config file at $config_file" >&2
  echo "       copy config/machine.env.example to config/machine.env and edit it" >&2
  exit 1
fi

# shellcheck source=/dev/null
source "$config_file"

# Arm models. SO-101 is the model in the LeRobot SO-101 guide.
ROBOT_TYPE="${ROBOT_TYPE:-so101_follower}"
TELEOP_TYPE="${TELEOP_TYPE:-so101_leader}"

# Calibration files live in this repo, not in LeRobot's default cache folder.
CALIBRATION_DIR="${CALIBRATION_DIR:-$repo_root/calibration}"

# Exit with a clear message when a config value is empty.
require() {
  local name
  for name in "$@"; do
    if [[ -z "${!name:-}" ]]; then
      echo "error: $name is empty in $config_file" >&2
      exit 1
    fi
  done
}

# Print a command (dry run) or run it.
run() {
  if [[ "${DRY_RUN:-0}" == 1 ]]; then
    printf '%q ' "$@"
    printf '\n'
  else
    "$@"
  fi
}

# Set the global `camera_args` to the camera option, or to nothing when
# CAMERA_INDEX is empty.
camera_args=()
build_camera_args() {
  camera_args=()
  if [[ -n "${CAMERA_INDEX:-}" ]]; then
    # shellcheck disable=SC2034  # read by the scripts that source this file
    camera_args=(
      "--robot.cameras={ ${CAMERA_NAME:-front}: {type: opencv, index_or_path: ${CAMERA_INDEX}, width: ${CAMERA_WIDTH:-640}, height: ${CAMERA_HEIGHT:-480}, fps: ${CAMERA_FPS:-30}}}"
    )
  fi
}

# Check the first argument is "follower" or "leader"; print it back.
arm_role() {
  case "${1:-}" in
    follower | leader) echo "$1" ;;
    *)
      echo "usage: $(basename "$0") follower|leader" >&2
      exit 1
      ;;
  esac
}
