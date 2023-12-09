#!/bin/bash
# [[file:setup.org::*Setup][Setup:1]]
sudo pacman -Syyu
# Setup:1 ends here

# [[file:setup.org::*Terminal, Nushell][Terminal, Nushell:1]]
yay --noconfirm -S alacritty curl libtool fzf fd ripgrep xclip xdg-utils cmake npm bat git gcc make xdotool tldr htop fish ttf-terminus-nerd terminus-font nushell tmux
# Terminal, Nushell:1 ends here

# [[file:setup.org::*Terminal, Nushell][Terminal, Nushell:2]]
sudo chsh -s /usr/bin/nu root
chsh -s /usr/bin/nu
# Terminal, Nushell:2 ends here

# [[file:setup.org::*Never sudo-password-prompt][Never sudo-password-prompt:1]]
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/$USER"
# Never sudo-password-prompt:1 ends here

# [[file:setup.org::*Make system-scripts executeable][Make system-scripts executeable:1]]
fd . ~/.config/bin -tf -x chmod +x {}
# Make system-scripts executeable:1 ends here

# [[file:setup.org::*Stupid xorg should be replaced (/uses it anyway/)][Stupid xorg should be replaced (/uses it anyway/):1]]
sudo ln -s ~/.config/xprofile ~/.xprofile
# Stupid xorg should be replaced (/uses it anyway/):1 ends here

# [[file:setup.org::*Editor: doom emacs][Editor: doom emacs:1]]
yay --noconfirm -S emacs-nativecomp

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
# Editor: doom emacs:1 ends here

# [[file:setup.org::*Gui apps & packages][Gui apps & packages:1]]
yay --noconfirm -S i3 i3lock zathura zathura-pdf-mupdf arandr mpv rofi light sxiv unclutter firefox pavucontrol pasystray polybar playerctl blueman xorg-xprop xremap-x11-bin polybar light thunar networkmanager network-manager-applet mpd dunst notify-send nsxiv xorg-xwininfo keepassxc maim pulsemixer xorg-xset xorg-xsetroot
# Gui apps & packages:1 ends here

# [[file:setup.org::*Enable daemons][Enable daemons:1]]
sudo systemctl enable sshd
sudo systemctl enable mpd
sudo systemctl enable bluetooth
# Enable daemons:1 ends here
