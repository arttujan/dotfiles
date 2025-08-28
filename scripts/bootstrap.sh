#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
backup="$HOME/.dotfiles_backup_$(date +%Y%m%d-%H%M)"

mkdir -p "$backup"

backup_if_exists() {
  local f="$1"
  if [ -e "$f" ] || [ -L "$f" ]; then
    echo "Backing up $f -> $backup/"
    mv "$f" "$backup/"
  fi
}

link_file() {
  local src="$1"
  local dest="$2"
  backup_if_exists "$dest"
  ln -sFh "$src" "$dest"
  echo "Linked $dest -> $src"
}

echo "==> Linking dotfiles from $repo_dir"
link_file "$repo_dir/.bashrc" "$HOME/.bashrc"
link_file "$repo_dir/.bash_profile" "$HOME/.bash_profile"
link_file "$repo_dir/.inputrc" "$HOME/.inputrc"

echo "==> Ensuring Homebrew bash is in /etc/shells and set as login shell"
brew_prefix="$(brew --prefix)"
brew_bash="$brew_prefix/bin/bash"
if ! grep -q "^${brew_bash}$" /etc/shells; then
  echo "Adding ${brew_bash} to /etc/shells (sudo required)"
  echo "${brew_bash}" | sudo tee -a /etc/shells >/dev/null
fi

if [ "$SHELL" != "$brew_bash" ]; then
  echo "Changing login shell to ${brew_bash}"
  chsh -s "${brew_bash}"
fi

echo "==> Done. Open a new terminal window."
