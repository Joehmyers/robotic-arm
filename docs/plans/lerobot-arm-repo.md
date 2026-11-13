# Plan: LeRobot arm repo

> **Status:** In Progress

## Overview

Turn the template into a small repo that runs a pair of SO-101 arms (one
leader you move by hand, one follower that copies it) with LeRobot, the Hugging
Face robot library. Per-computer details live in one config file. Short scripts
read it and run the LeRobot commands. Calibration files (each arm's joint
positions, so the two arms agree) are committed under `calibration/`, and the
scripts point LeRobot at that folder with `--robot.calibration_dir`.

## Steps

- [x] 1. `config/machine.env.example`: ports, camera numbers, arm IDs, Hugging Face user.
- [x] 2. `scripts/`: `find-port.sh`, `setup-motors.sh`, `calibrate.sh`, `teleoperate.sh`, `record.sh`, `versions.sh`, sharing `lib.sh`. `DRY_RUN=1` prints the command instead of running it.
- [x] 3. `calibration/README.md`: arm names and which physical arm each file belongs to.
- [x] 4. `docs/hardware.md`: motor ID record, arm identity, versions.
- [x] 5. `.gitignore`: tokens, datasets, models, the real machine config.
- [x] 6. `README.md`: replace the template overview with the arm guide.
- [x] 7. `tests/test_scripts.sh`: run each script in dry-run mode, assert the command.
- [x] 8. Wire the test into `ops/check.sh`; run it.

## Files changed

| File | Change |
|------|--------|
| `config/machine.env.example` | new, copy to `config/machine.env` |
| `scripts/*.sh` | new |
| `calibration/README.md` | new |
| `docs/hardware.md` | new |
| `.gitignore`, `README.md`, `AGENTS.md`, `ops/check.sh` | edited |
| `tests/test_scripts.sh`, `tests/fixtures/machine.env` | new |

## Verification

```bash
ops/check.sh
```

Not covered: the real arms. The scripts have not run against hardware.
