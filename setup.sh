#!/bin/bash
sudo pacman -Syyu

yay --noconfirm -S alacritty curl libtool xorg-xset fzf fd ripgrep xclip xdg-utils cmake npm bat git git-delta gcc make xdotool tldr htop carapace ttf-terminus-nerd terminus-font nushell tmux

sudo chsh -s /usr/bin/nu root
chsh -s /usr/bin/nu

echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/$USER"

fd . ~/.config/bin -tf -x chmod +x {}

yay --noconfirm -S emacs-nativecomp

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

yay --noconfirm -S i3 i3lock zathura zathura-pdf-mupdf arandr mpv rofi light wmctrl sxiv unclutter firefox pavucontrol pasystray polybar playerctl blueman xorg-xprop wmctrl xremap-x11-bin polybar light thunar networkmanager network-manager-applet mpd dunst notify-send nsxiv xorg-xwininfo keepassxc maim pulsemixer

sudo systemctl enable sshd
sudo systemctl enable mpd
sudo systemctl enable bluetooth
