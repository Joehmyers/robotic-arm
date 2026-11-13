#!/usr/bin/env bash
#
# find-port.sh: find the USB port of an arm.
#
# LeRobot asks you to unplug the arm's USB cable, then shows which port
# vanished. Run it once per arm and copy the result into config/machine.env.
# Needs no config file.
set -euo pipefail
exec lerobot-find-port
