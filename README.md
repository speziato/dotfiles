# Dotfiles

This is a collection of my personal dotfiles.

List of software:

- bash
- starship
- wezterm
- vim
- Visual Studio Code
- gamemode
- Spotify
- wireplumber

## Bash

For bash, some of the completion are converted from `eval` instruction to static files
for performance improvements.
You will find a comment inside the [`.bashrc`](.bashrc) file where applicable.

These are specifically reequired to be sourced like that because they do more than
just provide completions. Normally you can place completion files
under `$HOME/.local/share/bash-completions/<cli_name>`.

## Vim

I use [`vim-plug`](https://github.com/junegunn/vim-plug) to manage plugins. See the [`.vimrc`](.vimrc) file
to see the plugins I load. If you don't have `vim-plug` installed, it will be automatically downloaded the first time
you run `vim`.

## User systemd units

Copy unit files from [`.config/systemd/user`](.config/systemd/user/) inside your `$HOME/.config/systemd/user` folder
and, for each unit, run:

```bash
systemctl enable --user <unit_name>
```

## VSCode

You can find the list of extensions I use [here](.vscode/extensions.json).
This file is generated using the "recommended extensions for this workspace" function,
I just listed all of them.

The [`.config/Code`](.config/Code/) folder contains my keybindings and global settings.

The [`.config/code-flags.conf`](.config/code-flags.conf) file configures VSCode to run
correctly under Wayland.
