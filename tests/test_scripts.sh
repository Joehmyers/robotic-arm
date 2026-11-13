#!/usr/bin/env bash
#
# test_scripts.sh: run each arm script in dry-run mode and check the command
# it would run. Needs no robot and no LeRobot install.
set -uo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export ARM_CONFIG="$root/tests/fixtures/machine.env"
export DRY_RUN=1
failures=0

# expect <script and arguments> <text the output must contain>...
expect() {
  local call="$1" out text
  shift
  # shellcheck disable=SC2086  # $call splits into script plus argument on purpose
  out="$("$root/scripts/"$call 2>&1)"
  for text in "$@"; do
    if [[ "$out" != *"$text"* ]]; then
      echo "FAIL  $call: output lacks: $text" >&2
      echo "      got: $out" >&2
      failures=$((failures + 1))
    fi
  done
}

expect "calibrate.sh follower" lerobot-calibrate --robot.port=/dev/ttyTEST0 --robot.id=follower_test "--robot.calibration_dir=$root/calibration"
expect "calibrate.sh leader" lerobot-calibrate --teleop.port=/dev/ttyTEST1 --teleop.id=leader_test
expect "setup-motors.sh follower" lerobot-setup-motors --robot.port=/dev/ttyTEST0
expect "setup-motors.sh leader" lerobot-setup-motors --teleop.port=/dev/ttyTEST1
expect "teleoperate.sh" lerobot-teleoperate --robot.id=follower_test --teleop.id=leader_test "index_or_path:\ 2"
expect "record.sh" lerobot-record --dataset.repo_id=tester/demo --dataset.num_episodes=3 "--dataset.single_task=Test\ task"

# A bad role must fail, not guess.
if "$root/scripts/calibrate.sh" elbow >/dev/null 2>&1; then
  echo "FAIL  calibrate.sh accepted an unknown arm role" >&2
  failures=$((failures + 1))
fi

# No camera number means no camera option.
nocam="$(mktemp)"
trap 'rm -f "$nocam"' EXIT
{ cat "$ARM_CONFIG"; echo "CAMERA_INDEX="; } > "$nocam"
if ARM_CONFIG="$nocam" "$root/scripts/teleoperate.sh" 2>&1 | grep -q cameras; then
  echo "FAIL  teleoperate.sh passed a camera with CAMERA_INDEX empty" >&2
  failures=$((failures + 1))
fi

if ((failures)); then
  echo "$failures check(s) failed" >&2
  exit 1
fi
echo "all script checks passed"
