#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)

if ! vim -Nu NONE -n -es \
  "+source $root/vimrc" \
  '+if maparg("<F5>", "n") ==# "" | cquit | endif' \
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
  '+lua assert(vim.fn.maparg(" gs", "n") ~= "")' \
  '+lua assert(vim.fn.maparg("<C-Space>", "i") ~= "")' \
  '+lua assert(vim.fn.maparg("<C-k>", "i") ~= "")' \
  '+qa'

"$root/tests/install.sh"

printf 'SISUVim smoke tests passed.\n'
