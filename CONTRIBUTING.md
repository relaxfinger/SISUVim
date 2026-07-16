# Contributing to SISUVim

Thank you for helping make SISUVim durable and pleasant to use every day.

## Keymap stability

SISUVim protects established editing workflows while improving them carefully.
Do not repurpose an existing mapping without keeping its behavior or providing
a documented compatibility alias. Update [docs/keymaps.md](docs/keymaps.md)
and the smoke tests whenever a user-visible mapping changes.

## Development workflow

1. Create a focused branch and make one coherent change.
2. Run `./tests/smoke.sh`.
3. Document user-visible behavior in `README.md` and `CHANGELOG.md`.
4. Open a pull request with the compatibility impact and verification steps.

See [docs/releasing.md](docs/releasing.md) for the maintainer publication
checklist.

## Issue quality

Use the bug form for reproducible failures and the feature form for focused
proposals. Explain any keymap impact explicitly; preserving a coherent editing
workflow is more important than adding overlapping shortcuts.

## Scope

- Keep the Vim 9 core dependency-free and functional.
- Make Neovim features optional, lazy-loadable, and reproducible.
- Prefer built-in Neovim APIs before adding a dependency.
- Keep all contributions compatible with the MIT License.
