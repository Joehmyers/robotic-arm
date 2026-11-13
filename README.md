# robotic-arm

Runs a pair of SO-101 robot arms with [LeRobot](https://huggingface.co/docs/lerobot/so101),
the Hugging Face robot library. One arm, the **leader**, you move by hand. The
other, the **follower**, copies it. You can record those moves as a dataset
(a saved set of episodes) to train a model later.

Built from a template repo; `AGENTS.md` holds the rules for coding agents.

## Versions used

Run `scripts/versions.sh` and replace these lines with its output.

- Python: <!-- fill in, e.g. 3.10 -->
- LeRobot: <!-- fill in, e.g. 0.4.x; "editable" if installed from a git clone -->

## Install

1. Install LeRobot and its motor driver. The SO-101 motors are Feetech motors,
   and LeRobot loads their driver only when you ask for it. From a clone of
   LeRobot:

   ```bash
   pip install -e ".[feetech]"
   ```

   Or, from PyPI (the Python package index), if that is how you installed:

   ```bash
   pip install "lerobot[feetech]"
   ```

2. Copy the machine config and edit the copy:

   ```bash
   cp config/machine.env.example config/machine.env
   ```

3. Log in to Hugging Face once, so datasets can upload. The token stays in your
   home folder, never in this repo:

   ```bash
   huggingface-cli login
   ```

## Machine config

`config/machine.env` holds what differs between computers: the USB port of each
arm, the camera number, and the arm names. The scripts read it, so they stay the
same everywhere. Git ignores it; `config/machine.env.example` is the committed
template.

To find a port: `scripts/find-port.sh`. To find a camera number:
`lerobot-find-cameras opencv`.

## Run

| Step | Command |
|------|---------|
| Find an arm's USB port | `scripts/find-port.sh` |
| Set motor IDs (before assembly) | `scripts/setup-motors.sh follower` and `... leader` |
| Calibrate | `scripts/calibrate.sh follower` and `... leader` |
| Move the follower with the leader | `scripts/teleoperate.sh` |
| Record a dataset | `scripts/record.sh` |

Put `DRY_RUN=1` before any script to print the LeRobot command without running
it.

First time, in order: set up motors, calibrate both arms, teleoperate to
check, then record.

## Calibration

Calibration files are in `calibration/`, one per arm: `follower_1.json` and
`leader_1.json`. They work only for the arms they were made on. See
[calibration/README.md](calibration/README.md) for which physical arm each
belongs to, and what to do after a rebuild or swap.

## Motor setup record

Which motor got which ID is in [docs/hardware.md](docs/hardware.md).

## What is not in git

Git ignores your Hugging Face token, recorded datasets and trained models (see
`.gitignore`). Datasets and models are large, so keep them on Hugging Face.

## Check the repo

```bash
ops/check.sh
```

This tests that each script builds the right command. It does not need a robot.
It has not been run against real arms.
