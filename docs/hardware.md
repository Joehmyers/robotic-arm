# Hardware record

What is built, how each motor was set up, and which software versions ran it.
Update it whenever you rebuild an arm.

## Definitions

- **Motor ID**: a number from 1 to 253 that a motor answers to on the shared
  cable. Two motors on one cable must not share an ID.
- **Baud rate**: the speed of the motor's data link, in bits per second. Every
  motor on one cable must use the same rate.
- **Leader / follower**: the leader is moved by hand; the follower copies it.

## Arms

| Arm | Model | Name in config | Label on arm | Built on |
|-----|-------|----------------|--------------|----------|
| Follower | SO-101 | `follower_1` | <!-- fill in --> | <!-- date --> |
| Leader | SO-101 | `leader_1` | <!-- fill in --> | <!-- date --> |

## Motor setup record

`scripts/setup-motors.sh follower|leader` sets these. The SO-101 guide numbers
the six joints from the base up. Tick each box once you have set that motor,
and note any difference from the table.

Baud rate: 1,000,000 (the LeRobot default for these motors).

| Joint | Motor ID | Follower set | Leader set |
|-------|----------|--------------|------------|
| shoulder_pan | 1 | [ ] | [ ] |
| shoulder_lift | 2 | [ ] | [ ] |
| elbow_flex | 3 | [ ] | [ ] |
| wrist_flex | 4 | [ ] | [ ] |
| wrist_roll | 5 | [ ] | [ ] |
| gripper | 6 | [ ] | [ ] |

Leader motors may use different gear ratios per joint, depending on the kit.
Record the motor model for each joint here if yours differ:

- Leader: <!-- fill in -->
- Follower: <!-- fill in -->

## Software versions

Run `scripts/versions.sh` and paste the result into the README.
