#!/bin/bash

# Paste dots/
mkdir ~/.config/alacritty 2>/dev/null
mkdir ~/.config/kanshi 2>/dev/null
mkdir ~/scripts 2>/dev/null
mkdir ~/.config/rofi 2>/dev/null
mkdir ~/.config/i3status-rust 2>/dev/null
mkdir ~/.config/i3bar-river 2>/dev/null
mkdir ~/.config/river 2>/dev/null
cp -r ./dots/* ~/.config/
cp -r ./scripts/* ~/scripts/
cp ./repo-assets/wall ~/.river

echo -e "\e[32mDots applied :) have a great day...\e[0m"

echo -e "\e[33mPlease reboot your system to apply the changes\e[0m"
