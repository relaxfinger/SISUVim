#!/usr/bin/env bash
set -euo pipefail

root=$1
install_nvim=$2
install_vim=$3
if [ "$install_nvim" -eq 1 ]; then
  command -v nvim >/dev/null 2>&1 || {
    printf 'Neovim is required for --with-packages.\n' >&2
    exit 1
  }
  nvim --headless \
    --cmd "set rtp^=$root" \
    -u "$root/init.lua" \
    '+lua require("lazy").sync({ wait = true })' \
    '+qa'
fi

if [ "$install_vim" -eq 1 ]; then
  command -v lazygit >/dev/null 2>&1 || {
    printf 'LazyGit is optional but required for Vim <leader>gs. Install it with your system package manager.\n' >&2
  }
fi
