# SISUVim keymap contract

SISUVim keeps a compact, keyboard-first command vocabulary. The following
mappings are part of its stable editing contract and should change only with a
clear compatibility path and a release-note entry.

The leader key is `Space`.

| Area | Mapping | Action |
| --- | --- | --- |
| Movement | `j` / `k` | Move by display line when wrapping is enabled |
| Movement | `$` / `0` | Move to the display-line end or start when wrapping is enabled |
| Windows | `Ctrl-h/j/k/l` | Move between windows |
| Tabs | `Shift-h` / `Shift-l` | Previous / next tab |
| Search | `<leader>/` | Clear search highlighting |
| Files | `<leader>pf` | Find files |
| Files | `<leader>fg` | Search project text |
| Files | `<leader>fb` | Switch buffers |
| Files | `<leader>fr` | Open recent files |
| Files | `<leader>e` or `Ctrl-e` | Toggle file explorer |
| Files | `<leader>nt` | Reveal the current file in the explorer |
| Search | `<leader>ff` | Find keyword occurrences and jump to a selection |
| Editing | `Y` | Yank to the end of line |
| Editing | Visual `<` / `>` | Indent and retain the selection |
| Editing | Visual `.` | Repeat the last change across the selection |
| Editing | `<leader>ew/es/ev/et` | Edit, split, vertical split, or tab-edit in the current file's directory |
| Folding | `<leader>f0` … `<leader>f9` | Set fold level |
| Git | `<leader>gs` | Open Git status |
| Git | `]c` / `[c` | Next / previous changed hunk |
| Git | `<leader>hs/hr/hp` | Stage, reset, or preview a hunk |
| Diagnostics | `[d` / `]d` | Previous / next diagnostic |
| Diagnostics | `<leader>le` / `<leader>lq` | Show line diagnostics / populate location list |
| Snippets | `Ctrl-Space` | Expand a snippet or jump forward |
| Snippets | `Ctrl-k` | Jump backward in a snippet |

## Carefully modernized behavior

- File finding lives at `<leader>pf`, keeping `<leader>ff` available for its
  focused keyword workflow.
- The built-in snippet engine powers snippet navigation, so snippets remain
  available without a mandatory completion framework.
- Explorer, picker, Git hunk, and Tree-sitter features remain optional when a
  dependency cannot be loaded.

When proposing a keymap change, update this document, the smoke tests, and the
release notes in the same pull request.
