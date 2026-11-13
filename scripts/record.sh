#!/usr/bin/env bash
#
# record.sh: record episodes of you moving the leader arm, as a dataset.
#
# Usage: scripts/record.sh
#
# The dataset is named HF_USER/DATASET_NAME and is stored outside this repo, in
# LeRobot's cache folder. Run `huggingface-cli login` first, so LeRobot can
# upload it to Hugging Face. Do not copy datasets into this repo.
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

require FOLLOWER_PORT FOLLOWER_ID LEADER_PORT LEADER_ID HF_USER DATASET_NAME TASK_DESCRIPTION
build_camera_args

run lerobot-record \
  --robot.type="$ROBOT_TYPE" \
  --robot.port="$FOLLOWER_PORT" \
  --robot.id="$FOLLOWER_ID" \
  --robot.calibration_dir="$CALIBRATION_DIR" \
  ${camera_args[@]+"${camera_args[@]}"} \
  --teleop.type="$TELEOP_TYPE" \
  --teleop.port="$LEADER_PORT" \
  --teleop.id="$LEADER_ID" \
  --teleop.calibration_dir="$CALIBRATION_DIR" \
  --display_data=true \
  --dataset.repo_id="$HF_USER/$DATASET_NAME" \
  --dataset.num_episodes="${NUM_EPISODES:-5}" \
  --dataset.single_task="$TASK_DESCRIPTION"
