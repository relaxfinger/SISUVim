# Vim interface

The Vim 9 experience is intentionally native and lightweight: it does not
require a UI plugin to provide a cohesive workspace.

When Vim starts without a file, SISUVim opens a Dashboard and a 28-column
Netrw tree sidebar rooted at the current directory. Open a file from the tree
or use the Dashboard shortcuts. Start Vim with a filename to open that file
directly without the Dashboard.

## Interface controls

- `F5`, `<leader>e`, `Ctrl-e` — open the Netrw tree sidebar.
- `<leader>sh` — return to the Dashboard.
- `:SISUDashboard` — open the Dashboard from command mode.
- `:Lexplore 28` — open the native tree sidebar explicitly.

The interface adds a persistent statusline, a tabline, true-colour support
where available, and a restrained dark colour palette. Set
`g:sisuvim_disable_startup_ui = 1` before Vim starts to disable the automatic
Dashboard and tree for a session.
