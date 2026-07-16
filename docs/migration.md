# spf13-vim migration map

SISUVim is a rewrite, not a relicense of the older distribution. This document
tracks user-visible behavior that is intentionally kept during the migration.

## Available in the foundation

| Legacy behavior | SISUVim mapping |
| --- | --- |
| Move by displayed line | `j` / `k` |
| Focus and maximize adjacent window | `Ctrl-h/j/k/l` |
| Navigate tabs | `Shift-h` / `Shift-l` |
| Toggle background | `<leader>bg` |
| Set fold level | `<leader>f0` … `<leader>f9` |
| Clear search highlight | `<leader>/` |
| Current-directory edit/split/tab | `<leader>ew/es/ev/et` |
| File explorer | `F5`, `<leader>e` |
| Find files | `<leader>ff` |
| Search project text | `<leader>fg` |
| Find buffers / recent files | `<leader>fb` / `<leader>fr` |
| Git status / diff / commit / blame / log | `<leader>gs/gd/gc/gb/gl` |
| Git push / read / write / edit / patch add | `<leader>gp/gr/gw/ge/gi` |
| Toggle Git signs | `<leader>gg` |
| LSP definition / declaration / implementation / references | `<leader>ld/lD/li/lr` |
| LSP code action / rename / format | `<leader>la/ln/lf` |
| Repeat visual indent | `<` / `>` |

The leader remains Space. Neovim uses an optional native-package module for
the explorer and picker, with built-in `:Explore` as a failure-safe fallback.

## Deliberately deferred

- Treesitter and language-specific tooling beyond built-in LSP.
- Plugin-specific mappings such as Syntastic and
  YouCompleteMe.
- Language-specific mappings.

Each deferred capability will be introduced as an optional module with a pinned
version and a documented compatibility mapping. This avoids startup failures
and lets users opt into modern replacements one feature at a time.
