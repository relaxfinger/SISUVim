#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}

link_file() {
  local source=$1 target=$2
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    printf 'Refusing to replace existing file: %s\n' "$target" >&2
    return 1
  fi
  ln -sfn "$source" "$target"
}

link_file "$root" "$config_home/nvim"
link_file "$root/vimrc" "$HOME/.vimrc"
printf 'SISUVim installed. Start nvim or vim to verify.\n'
