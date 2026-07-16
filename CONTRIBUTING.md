# Contributing to SISUVim

Thank you for helping make SISUVim a durable successor to spf13-vim.

## Compatibility first

SISUVim preserves the established spf13-vim editing workflow. Do not repurpose
an existing mapping without keeping its behavior or providing a documented
compatibility alias. Update [docs/migration.md](docs/migration.md) and the
smoke tests whenever a user-visible mapping changes.

## Development workflow

1. Create a focused branch and make one coherent change.
2. Run `./tests/smoke.sh`.
3. Document user-visible behavior in `README.md` and `CHANGELOG.md`.
4. Open a pull request with the compatibility impact and verification steps.

## Scope

- Keep the Vim 9 core dependency-free and functional.
- Make Neovim features optional, lazy-loadable, and reproducible.
- Prefer built-in Neovim APIs before adding a dependency.
- Do not copy code from the Apache-2.0 ancestor into this MIT project.
