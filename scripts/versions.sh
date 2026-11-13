#!/usr/bin/env bash
#
# versions.sh: print the Python and LeRobot versions, to paste into README.md.
# Needs no config file.
set -euo pipefail
python --version
pip show lerobot | grep -E '^(Name|Version|Editable project location)'
