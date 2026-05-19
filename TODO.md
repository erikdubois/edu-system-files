# TODO

## In Progress

## Planned

### kiro-lint — follow-on
- `snd_hda_intel.stateful_codec` flagged FAIL (not exposed in lqx 7.0.9 parameters) — verify on a vanilla Arch kernel or remove from audio-hda.conf if the param doesn't exist upstream

### Phase 2 — Script flags
- Add `--help` and `--dry-run` to all `usr/local/bin/` scripts

### Phase 3 — Config files
- Externalize hardcoded values into config files

### Phase 4 — Quality pass
- Full shellcheck + shfmt pass on all scripts

## Done
- Phase 1: unified library, error handling, variable quoting (2026.04.20)
- kiro-verify post-install verification script (2026.05.18)
