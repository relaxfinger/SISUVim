#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)

if ! vim -Nu NONE -n -es \
  "+source $root/vimrc" \
  '+if maparg("<F5>", "n") ==# "" | cquit | endif' \
  '+if maparg(" gs", "n") ==# "" | cquit | endif' \
  '+if exists(":SISULazyGit") != 2 | cquit | endif' \
  '+qa'; then
  vim -Nu NONE -n -e -V1 \
    "+source $root/vimrc" \
    '+if maparg("<F5>", "n") ==# "" | cquit | endif' \
    '+qa' || true
  exit 1
fi

nvim --clean --headless \
  --cmd "set rtp^=$root" \
  --cmd 'let g:sisuvim_disable_packages=1' \
  -u "$root/init.lua" \
  '+lua assert(vim.fn.maparg(" ff", "n") ~= "")' \
  '+lua assert(vim.fn.maparg(" pf", "n") ~= "")' \
  '+lua assert(vim.fn.maparg(" fc", "n") ~= "")' \
  '+lua assert(vim.fn.maparg(" gs", "n") ~= "")' \
  '+lua assert(vim.fn.maparg("[d", "n") ~= "")' \
  '+lua assert(vim.fn.maparg("]d", "n") ~= "")' \
  '+lua assert(vim.fn.maparg(" le", "n") ~= "")' \
  '+lua assert(vim.fn.maparg("<C-Space>", "i") ~= "")' \
  '+lua assert(vim.fn.maparg("<C-k>", "i") ~= "")' \
  '+qa'

config_home=$(mktemp -d)
mkdir -p "$config_home/sisuvim"
printf '%s\n' 'return { disable_packages = true, format_on_save = true, options = { shiftwidth = 2, wrap = true } }' > "$config_home/sisuvim/config.lua"
XDG_CONFIG_HOME="$config_home" nvim --clean --headless \
  --cmd "set rtp^=$root" \
  -u "$root/init.lua" \
  '+lua assert(require("sisuvim.config").get().format_on_save)' \
  '+lua assert(vim.o.shiftwidth == 2 and vim.o.wrap)' \
  '+qa'

"$root/tests/install.sh"

printf 'SISUVim smoke tests passed.\n'
