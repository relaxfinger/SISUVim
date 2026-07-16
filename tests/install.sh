#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
temp=$(mktemp -d)
trap 'rm -rf "$temp"' EXIT

mkdir -p "$temp/config/nvim" "$temp/home"
printf 'existing nvim config\n' > "$temp/config/nvim/init.lua"
printf 'existing vim config\n' > "$temp/home/.vimrc"

HOME="$temp/home" XDG_CONFIG_HOME="$temp/config" "$root/install.sh"

test -L "$temp/config/nvim"
test "$(readlink "$temp/config/nvim")" = "$root"
test -L "$temp/home/.vimrc"
test "$(readlink "$temp/home/.vimrc")" = "$root/vimrc"
test -f "$temp/config/nvim.sisuvim-backup-"*/init.lua
test -f "$temp/home/.vimrc.sisuvim-backup-"*

HOME="$temp/home" XDG_CONFIG_HOME="$temp/config" "$root/install.sh" --dry-run --nvim
printf 'SISUVim installer tests passed.\n'
