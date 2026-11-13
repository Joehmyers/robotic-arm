#!/usr/bin/env bash
#
# setup-motors.sh: give each motor of one arm its ID and communication speed.
#
# Usage: scripts/setup-motors.sh follower|leader
#
# Do this before assembly, with one motor plugged in at a time, as LeRobot
# prompts. Write the result in docs/hardware.md.
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

role="$(arm_role "${1:-}")"
if [[ "$role" == follower ]]; then
  require FOLLOWER_PORT
  run lerobot-setup-motors --robot.type="$ROBOT_TYPE" --robot.port="$FOLLOWER_PORT"
else
  require LEADER_PORT
  run lerobot-setup-motors --teleop.type="$TELEOP_TYPE" --teleop.port="$LEADER_PORT"
fi
