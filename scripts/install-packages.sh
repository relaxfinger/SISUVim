#!/usr/bin/env bash
set -euo pipefail

root=$1
install_nvim=$2
install_vim=$3
data_home=${XDG_DATA_HOME:-"$HOME/.local/share"}

install_vim_package() {
  local name=$1
  local url=$2
  local revision=$3
  local destination="$data_home/vim/pack/sisuvim/start/$name"
  mkdir -p "$(dirname "$destination")"
  if [ -d "$destination/.git" ]; then
    git -C "$destination" fetch --depth=1 origin "$revision"
  else
    git clone --filter=blob:none --no-checkout "$url" "$destination"
    git -C "$destination" fetch --depth=1 origin "$revision"
  fi
  git -C "$destination" checkout --detach "$revision"
}

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
  command -v git >/dev/null 2>&1 || {
    printf 'git is required for --with-packages.\n' >&2
    exit 1
  }
  install_vim_package \
    vim-fugitive \
    https://github.com/tpope/vim-fugitive \
    3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0
fi
