# Dotfiles

just my dotfiles for my linux environment

## Used applications/language:

- i3
- i3blocks
- i3lock
- st
- tmux
- vim
- python
- bash
- sshrc
- rofi
- rofi-polkit-agent

## Systemd Services

- acpi-wake.service - makes sure resume from suspend only happens when clicking the power button

## installing

1. Backup the following files/folders unless its a fresh install:
    - ~/.i3
    - ~/.config/i3/config
    - ~/.ssh
    - ~/.bashrc
    - ~/.tmux.conf
    - ~/.vimrc
    - ~/.sshrc
    - ~/.Xresources

2. Install the used applications

3. copy or link the files to the specific folders
    - ${project_root}/.i3 to  ~/.i3
    - ${project_root}/.config/i3/config to ~/.config/i3/config
    - ${project_root}/.ssh to ~/.ssh
    - ${project_root}/.bashrc to ~/.bashrc
    - ${project_root}/.tmux.conf to ~/.tmux.conf
    - ${project_root}/.vimrc to ~/.vimrc
    - ${project_root}/.sshrc to ~/.sshrc
    - ${project_root}/.Xresources to ~/.Xresources

# Patches

  - patch to ST - allows zoom with mouse wheel