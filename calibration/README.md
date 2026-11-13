# Calibration files

A calibration file records one arm's joint positions, so the leader and the
follower agree on what "straight up" means. The scripts point LeRobot here with
`--robot.calibration_dir` and `--teleop.calibration_dir`, so LeRobot reads and
writes these files in place. No copying.

| File | Arm | Made by |
|------|-----|---------|
| `follower_1.json` | Follower arm (the one that does the work) | `scripts/calibrate.sh follower` |
| `leader_1.json` | Leader arm (the one you move by hand) | `scripts/calibrate.sh leader` |

The file names come from `FOLLOWER_ID` and `LEADER_ID` in
`config/machine.env`. Change one and you must rename the file to match.

## Which physical arms these belong to

Fill in once the files exist:

- `follower_1.json`: <!-- e.g. "SO-101 follower, assembled 2026-11-20, label on base: F1" -->
- `leader_1.json`: <!-- e.g. "SO-101 leader, assembled 2026-11-20, label on base: L1" -->

## Limit

A file works only for the arm it was made on. After a rebuild, a motor swap or
an arm swap, run `scripts/calibrate.sh` again, then commit the new file.

## Adding calibration made outside this repo

If you calibrated before using these scripts, LeRobot saved the files under
`~/.cache/huggingface/lerobot/calibration/` (in `robots/so101_follower/` and
`teleoperators/so101_leader/`; check the folder names on your install). Copy
each `.json` file here and name it to match the arm ID.
