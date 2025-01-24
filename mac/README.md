# Mac dotfiles

This folder contains dotfiles that are specific to macOS. They are supposed to be installed alongside the main bash ones.

Big source of inspiration (more like _shamelessly copy the entire thing_): [Phantas0s dotfiles](https://github.com/Phantas0s/.dotfiles/tree/master/zsh)

## Homebrew

Install [Homebrew](https://brew.sh/) and then run:

```bash
brew install --formula $(brew-formulas.list)
brew install --cask $(brew-casks.list)
```

## Settings

Swap CTRL and CMD in Settings.
