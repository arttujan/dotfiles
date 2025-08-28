# ----- Homebrew env (path, man, etc.) -----
if command -v brew >/dev/null 2>&1; then
  eval "$($(brew --prefix)/bin/brew shellenv)"
fi

# Load interactive settings
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
