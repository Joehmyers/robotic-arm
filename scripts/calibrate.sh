#!/usr/bin/env bash
#
# calibrate.sh: record one arm's joint positions.
#
# Usage: scripts/calibrate.sh follower|leader
#
# LeRobot saves <arm id>.json in calibration/. Commit that file. Calibrate the
# leader and the follower separately, and again after any rebuild or swap.
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

role="$(arm_role "${1:-}")"
if [[ "$role" == follower ]]; then
  require FOLLOWER_PORT FOLLOWER_ID
  run lerobot-calibrate \
    --robot.type="$ROBOT_TYPE" \
    --robot.port="$FOLLOWER_PORT" \
    --robot.id="$FOLLOWER_ID" \
    --robot.calibration_dir="$CALIBRATION_DIR"
else
  require LEADER_PORT LEADER_ID
  run lerobot-calibrate \
    --teleop.type="$TELEOP_TYPE" \
    --teleop.port="$LEADER_PORT" \
    --teleop.id="$LEADER_ID" \
    --teleop.calibration_dir="$CALIBRATION_DIR"
fi
