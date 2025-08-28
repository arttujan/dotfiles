# Bash-First macOS Dotfiles (Homebrew Bash, Completion, FZF)
(If anyone else but me is reading this and wonders why bash, because its faster than zsh)

This repo contains a minimal, modern **bash** setup for macOS with:
- Homebrew **bash** (v5+)
- **bash-completion** v2
- **fzf** (fuzzy finder) keybindings & completion
- Sensible readline options via `.inputrc`
- Optional `bash-git-prompt` integration

> Works on Apple Silicon **and** Intel Macs. Paths auto-resolve via `$(brew --prefix)`.

## 1) Install dependencies
```bash
brew install bash bash-completion@2 fzf
# optional but nice:
brew install bash-git-prompt
# enable fzf integrations
"$(brew --prefix)"/opt/fzf/install
```

## 2) Make Homebrew bash your login shell
```bash
# Add Homebrew bash to allowed shells
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells

# Switch your user’s login shell
chsh -s "$(brew --prefix)/bin/bash"
```

## 3) (Optional) Clean up zsh configs
Backup any zsh configs so bash is the only shell touching your session:
```bash
backup="$HOME/.dotfiles_backup_zsh_$(date +%Y%m%d-%H%M)"
mkdir -p "$backup"
mv ~/.zshenv ~/.zprofile ~/.zshrc ~/.zlogin ~/.zlogout ~/.p10k.zsh ~/.oh-my-zsh 2>/dev/null "$backup" || true
# iTerm2 integration snippets (if present)
mv ~/.iterm2_shell_integration.zsh ~/.iterm2_shell_integration.bash 2>/dev/null "$backup" || true
# remove any 'exec zsh' from bash files
sed -i '' '/exec zsh/d' ~/.bash_profile 2>/dev/null || true
sed -i '' '/exec zsh/d' ~/.bashrc 2>/dev/null || true
```

## 4) Deploy these dotfiles
You can symlink them with the provided script:
```bash
./scripts/bootstrap.sh
```
This will **backup** any existing `~/.bashrc`, `~/.bash_profile`, and `~/.inputrc` and replace them with symlinks to this repo.

## 5) iTerm2 / Terminal
- iTerm2 → Preferences → Profiles → General → **Command** → `$(brew --prefix)/bin/bash -l`
  (leave “Send text at start” empty)
- Apple Terminal → Settings → Profiles → **Shells open with** → **Command** → `$(brew --prefix)/bin/bash -l`

## Verify
Open a new terminal and run:
```bash
echo "$SHELL"                 # -> /opt/homebrew/bin/bash or /usr/local/bin/bash
echo "$BASH_VERSION"          # -> 5.x
type _init_completion         # should resolve (from bash-completion)
type fzf                      # should resolve
```

## What’s inside?
- **.bash_profile**: Bootstraps Homebrew env and then loads `.bashrc`.
- **.bashrc**: History behavior, sane shell options, prompt, bash-completion, fzf.
- **.inputrc**: Case-insensitive, friendlier readline completion.
- **scripts/bootstrap.sh**: Safe symlink installer with backups.
