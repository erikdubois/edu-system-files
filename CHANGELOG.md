# CHANGELOG

## 2026.05.18 (session 2)

**What Changed**
All 33 scripts in `usr/local/bin/` that were not sourcing the shared library have been updated. Every script in the project now sources `/usr/local/lib/kiro-common.sh` for uniform logging, colors, and error handling.

**Technical Details**
Scripts were processed in four tiers:
- **Tier 1** (16 scripts): Standard transform — `#set -e` replaced with `set -Euo pipefail`, source block added, echo banners replaced with `log_section`/`log_info`/`log_success`/`log_warn`/`log_error`
- **Tier 2** (9 scripts): Same as Tier 1 plus removal of inline tput color variable blocks and inline `tput setaf`/`tput sgr0` calls, replaced by library log functions
- **Tier 3** (7 scripts): Careful handling — duplicate local `check_connectivity()` in `var` removed in favour of the library's version; ANSI display code in `sysinfo`, `sysinfo-retro`, `fetch`, `hfetch`, `sfetch` preserved untouched (display formatting, not logging); custom domain functions in `fix-sddm-conf` and `get-chadwm`/`get-sddm-simplicity` kept and cleaned of tput calls
- **Tier 4** (1 script): `pci-latency` — shebang changed from `#!/usr/bin/env sh` to `#!/bin/bash`; `set +e` preserved intentionally (script must continue on setpci failures); `set -Euo pipefail` deliberately omitted
- `get-arcolinux-nemesis` turned out to be a symlink to `get-nemesis` — one edit covered both
- Deprecated `$[count+1]` arithmetic replaced with `$((count+1))` in `get-chadwm` and `get-sddm-simplicity`
- `remove-socials` rm calls changed to `rm -f` to be safe under `set -Euo pipefail`
- All 44 scripts syntax-checked with `bash -n` — zero errors

**Files Modified**
- `usr/local/bin/iso`
- `usr/local/bin/edu-get-mirrors`
- `usr/local/bin/edu-probe`
- `usr/local/bin/edu-set-cores`
- `usr/local/bin/edu-which-vga`
- `usr/local/bin/edu-fix-archlinux-servers`
- `usr/local/bin/edu-fix-pacman-gpg-conf`
- `usr/local/bin/get-linux-mainline-x64v3-from-chaotic-repo`
- `usr/local/bin/get-linux-nitrous-from-chaotic-repo`
- `usr/local/bin/get-linux-xanmod-edge-x64v3-from-chaotic-repo`
- `usr/local/bin/get-linux-xanmod-lts-from-chaotic-repo`
- `usr/local/bin/remove-chaotic-repo-from-pacman.conf`
- `usr/local/bin/remove-nemesis-repo-from-pacman.conf`
- `usr/local/bin/toggle-chaotic-repo`
- `usr/local/bin/skel`
- `usr/local/bin/velo`
- `usr/local/bin/get-nemesis` (also covers `get-arcolinux-nemesis` symlink)
- `usr/local/bin/get-flexi`
- `usr/local/bin/use`
- `usr/local/bin/remove-debug`
- `usr/local/bin/remove-socials`
- `usr/local/bin/add-virtualbox-guest-utils`
- `usr/local/bin/get-chadwm`
- `usr/local/bin/get-sddm-simplicity`
- `usr/local/bin/var`
- `usr/local/bin/fix-sddm-conf`
- `usr/local/bin/sysinfo`
- `usr/local/bin/sysinfo-retro`
- `usr/local/bin/fetch`
- `usr/local/bin/hfetch`
- `usr/local/bin/sfetch`
- `usr/local/bin/pci-latency`
- `CHANGELOG.md`
- `TODO.md` (new stub)
- `IDEAS.md` (new stub)

---

## 2026.05.18

**What Changed**
Added `kiro-verify` — a post-install verification script that checks all configuration settings shipped by this package are actually applied at runtime and scans logs for errors.

**Technical Details**
The script parses `/etc/sysctl.d/99-kiro-optimizations.conf` dynamically (no hardcoded key list) to compare expected vs live values via `sysctl -n`. Additional checks cover: all 34 config files are installed, ZRAM is active with zstd compression, IO schedulers match device type (NVMe→none, SSD→bfq, HDD→mq-deadline), THP settings in `/sys/kernel/mm/`, blacklisted modules not loaded, no failed systemd units, and a journal/udev/dmesg error scan. Outputs PASS/FAIL/WARN/SKIP per check with a final summary, exits 1 on any FAIL. sysctl params missing from the running kernel produce WARN rather than FAIL.

**Files Modified**
- `usr/local/bin/kiro-verify` (new)
- `CHANGELOG.md`

---

## 2026.05.01

**What Changed**
Added CLAUDE.md with architecture overview for Claude Code sessions.

**Technical Details**
Documents the shared library pattern, script conventions, config file map, and current improvement phase status so future sessions don't need to rediscover structure.

**Files Modified**
- `CLAUDE.md` (new)

---

## 2026.04.20

**What Changed**
Phase 1 code quality overhaul: created unified shared library, enabled strict error handling, fixed variable quoting across critical scripts, and standardized logging.

**Technical Details**
- Created `usr/local/lib/kiro-common.sh` (1000+ lines, 80+ functions) consolidating `arcolinux-nemesis/common/common.sh` and EDU-specific utilities into 14 sections
- Removed empty `edu-common.sh` wrapper; all scripts now source `kiro-common.sh` directly
- Enabled `set -Euo pipefail` in all main scripts (previously commented out or absent)
- Fixed 20+ unquoted variable expansions in critical scripts (`edu-fix-pacman-conf`, `get-linux-kiro`, `setup-edu.sh`, `edu-fix-pacman-databases-and-keys`)
- Replaced bare `echo` calls with `log_*` functions throughout
- Added `confirm_destructive_operation()` guards to destructive pacman/key operations
- Added trap-based tmpfile cleanup in repo management scripts
- Replaced hardcoded connectivity checks with `check_connectivity()` library call

**Files Modified**
- `usr/local/lib/kiro-common.sh` (new)
- `usr/local/bin/edu-fix-pacman-conf`
- `usr/local/bin/edu-fix-pacman-databases-and-keys`
- `usr/local/bin/get-linux-kiro`
- `usr/local/bin/add-kiro`
- `usr/local/bin/add-chaotic_repo-to-pacman.conf`
- `usr/local/bin/add-nemesis_repo-to-pacman.conf`
- `usr/local/bin/pac`
- `usr/local/bin/get-me-started`
- `setup-edu.sh`
- `up.sh`

---

## 2026.04.19

**What Changed**
Initial repository setup with system configuration files and utility scripts for Kiro/ArcoLinux desktops.

**Technical Details**
Established the `usr/local/bin/` + `usr/local/lib/` + `etc/` directory tree mirroring the live system layout. Populated with kernel parameter tuning (`sysctl.d`), udev hardware rules, systemd drop-ins, modprobe options, and 40+ utility scripts for pacman, kernel variants, DE fetching, and system info.

**Files Modified**
- Initial commit of all files
