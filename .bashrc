# ===== History =====
shopt -s histappend           # append to history file, don't overwrite
PROMPT_COMMAND='history -a'   # write after each command
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoredups:erasedups
shopt -s cmdhist              # combine multi-line commands

# ===== Behaviors =====
shopt -s autocd               # 'cd' by typing directory name
shopt -s cdspell              # fix minor typos in 'cd'
shopt -s dirspell             # fix minor typos during completion
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar             # ** recursive globbing

# ===== Prompt =====
# Simple, fast prompt. Enable bash-git-prompt below for a fancier one.
PS1='\u@\h:\w\$ '

# ===== Completion Core =====
# Enable programmable completion if disabled
shopt -s progcomp 2>/dev/null

# bash-completion v2 (Homebrew)
if [ -f "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
  . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

# fzf keybindings & completion
if [ -f "$HOME/.fzf.bash" ]; then
  . "$HOME/.fzf.bash"
fi

# ===== Optional: bash-git-prompt =====
# Uncomment to enable a nice Git-aware prompt only when in a repo.
# if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#   GIT_PROMPT_ONLY_IN_REPO=1
#   source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
# fi
