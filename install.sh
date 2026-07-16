#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
install_nvim=1
install_vim=1
install_packages=0
dry_run=0
timestamp=$(date -u +%Y%m%dT%H%M%SZ)

usage() {
  cat <<'EOF'
Usage: ./install.sh [OPTIONS]

Safely links SISUVim into the current user's configuration. Existing files and
directories are moved to a timestamped sibling backup; they are never deleted.

Options:
  --nvim            Install only the Neovim configuration.
  --vim             Install only the Vim configuration.
  --with-packages   Install reproducible optional packages after linking.
  --dry-run         Print planned changes without writing anything.
  -h, --help        Show this help.
EOF
}

run() {
  if [ "$dry_run" -eq 1 ]; then
    printf '+ '
    printf '%q ' "$@"
    printf '\n'
  else
    "$@"
  fi
}

backup_path() {
  local target=$1 candidate="${target}.sisuvim-backup-${timestamp}" suffix=1
  while [ -e "$candidate" ] || [ -L "$candidate" ]; do
    candidate="${target}.sisuvim-backup-${timestamp}-${suffix}"
    suffix=$((suffix + 1))
  done
  printf '%s\n' "$candidate"
}

link_path() {
  local source=$1 target=$2 backup

  run mkdir -p "$(dirname "$target")"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    printf 'Already linked: %s\n' "$target"
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    backup=$(backup_path "$target")
    printf 'Backing up %s -> %s\n' "$target" "$backup"
    run mv "$target" "$backup"
  fi

  printf 'Linking %s -> %s\n' "$target" "$source"
  run ln -s "$source" "$target"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --nvim) install_vim=0 ;;
    --vim) install_nvim=0 ;;
    --with-packages) install_packages=1 ;;
    --dry-run) dry_run=1 ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'Unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

if [ "$install_nvim" -eq 1 ]; then
  link_path "$root" "$config_home/nvim"
fi

if [ "$install_vim" -eq 1 ]; then
  link_path "$root/vimrc" "$HOME/.vimrc"
fi

if [ "$install_packages" -eq 1 ]; then
  if [ "$dry_run" -eq 1 ]; then
    printf '+ %q %q\n' "$root/scripts/install-packages.sh" "$root"
  else
    "$root/scripts/install-packages.sh" "$root" "$install_nvim" "$install_vim"
  fi
fi

printf 'SISUVim installation complete.\n'
