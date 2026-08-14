# Project notes for agents

Deliberate decisions in this repo - do NOT silently revert them:

- `homebrew.onActivation.cleanup = "none"` in `configuration.nix` is intentional and pairs with `nix-homebrew.autoMigrate = true`. This fork adopts a pre-existing `/opt/homebrew` rather than starting from a clean prefix, so packages installed by hand predate the config. `"zap"` (the upstream value) would uninstall every one of them on the first switch. Do not restore `"zap"` or `"uninstall"` without first declaring the machine's existing brews and casks in the `brews`/`casks` arrays.
- Never commit `.no-mistakes/` validation evidence to this public repo. `.no-mistakes/` is gitignored; if a validation pipeline stages evidence into a branch, drop it before merging.

## Maintaining this file

Keep this file for knowledge useful to almost every future agent session in this project.
Do not repeat what the codebase already shows; point to the authoritative file or command instead.
Prefer rewriting or pruning existing entries over appending new ones.
When updating this file, preserve this bar for all agents and keep entries concise.
