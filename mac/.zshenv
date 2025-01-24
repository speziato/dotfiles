export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR="vim"
export VISUAL="vim"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

export KUBECTL_EXTERNAL_DIFF="dyff between --omit-header --set-exit-code"

export PROJECTS=~/projects


# PATH
# Add VSCode CLI
export PATH="$HOME/.local/bin:/usr/local/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"