# IDEAS

## Backlog

## Claude's Ideashop

**`kiro-disable-ssh` companion script**
Add a `kiro-disable-ssh` that stops and disables `sshd`, then optionally removes the `openssh` package. Rationale: enabling SSH on an ad-hoc basis for remote access implies you may want to lock it down again afterward — a paired disable script completes the workflow and avoids leaving a forgotten open port on machines that don't need persistent SSH.

**Static config linter for `etc/` files**
Add a `kiro-lint` script that statically analyses the `etc/` directory before deployment: checks for duplicate sysctl keys within the same file, verifies udev `ATTR{}` writes reference known sysfs paths, cross-checks modprobe.d parameters against the actual loaded driver's `/sys/module/*/parameters/`, and flags conflicting settings across files (e.g. power_save in both modprobe.d and a udev rule). Rationale: the audit this session found 23 issues — a linter would have caught most of them automatically before they ever shipped to users.

**`kiro-audit --baseline` — regression detection across updates**
Add a `--baseline` flag that saves the current audit result (pass/fail/warn per check) to `/var/lib/kiro/audit-baseline.json`. Subsequent runs with `--diff` compare against the saved baseline and show only checks that changed state since the snapshot. Rationale: running `kiro-audit` after a system update today gives you a wall of green PASSes — finding the one new FAIL requires reading the whole output. A baseline diff surfaces regressions immediately and makes post-update review a 5-second scan instead of a full read.
