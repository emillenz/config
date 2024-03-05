#!/bin/bash
# [[file:setup.org::*Setup][Setup:1]]
sudo pacman --syncyyu
# Setup:1 ends here

# [[file:setup.org::*Terminal, Nushell][Terminal, Nushell:1]]
yay --noconfirm --sync alacritty curl libtool fzf fd ripgrep xclip xdg-utils cmake npm bat git gcc make xdotool tldr htop fish ttf-iosevka-nerd nushell tmux
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

# [[file:setup.org::*Editor: doom emacs][Editor: doom emacs:1]]
yay --noconfirm --sync emacs-nativecomp
yay --noconfirm --sync wordnet-cli # NOTE :: dictionary dependency

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
# Editor: doom emacs:1 ends here

# [[file:setup.org::*Gui apps & packages][Gui apps & packages:1]]
yay --noconfirm --sync i3 i3lock zathura zathura-pdf-mupdf arandr mpv yt-dlp rofi light sxiv unclutter firefox pavucontrol pasystray playerctl blueman xorg-xprop xremap-x11-bin light networkmanager mpd dunst notify-send nsxiv maim pulsemixer xorg-xset xorg-xsetroot batsignal
# Gui apps & packages:1 ends here

# [[file:setup.org::*Enable daemons][Enable daemons:1]]
sudo systemctl enable sshd
sudo systemctl enable mpd
sudo systemctl enable bluetooth
# Enable daemons:1 ends here
