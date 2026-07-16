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
| Repeat visual indent | `<` / `>` |

The leader remains Space. SISUVim deliberately uses built-in `:Explore` during
the foundation stage instead of making a file-tree plugin mandatory.

## Deliberately deferred

- LSP, completion, Treesitter, Git UI, fuzzy finding, and file-tree plugins.
- Plugin-specific mappings such as NERDTree, CtrlP, Fugitive, Syntastic, and
  YouCompleteMe.
- Language-specific mappings.

Each deferred capability will be introduced as an optional module with a pinned
version and a documented compatibility mapping. This avoids startup failures
and lets users opt into modern replacements one feature at a time.
