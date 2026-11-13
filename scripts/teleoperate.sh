#!/usr/bin/env bash
#
# teleoperate.sh: move the leader arm by hand; the follower copies it.
#
# Usage: scripts/teleoperate.sh
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

require FOLLOWER_PORT FOLLOWER_ID LEADER_PORT LEADER_ID
build_camera_args

run lerobot-teleoperate \
  --robot.type="$ROBOT_TYPE" \
  --robot.port="$FOLLOWER_PORT" \
  --robot.id="$FOLLOWER_ID" \
  --robot.calibration_dir="$CALIBRATION_DIR" \
  ${camera_args[@]+"${camera_args[@]}"} \
  --teleop.type="$TELEOP_TYPE" \
  --teleop.port="$LEADER_PORT" \
  --teleop.id="$LEADER_ID" \
  --teleop.calibration_dir="$CALIBRATION_DIR" \
  --display_data=true
