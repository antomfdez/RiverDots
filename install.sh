#!/bin/bash

# Check if the script is run as root (e.g., with sudo)
if [ "$(id -u)" -eq 0 ]; then
    echo "This script must not be run as root or with sudo!"
    exit 1
fi

# Check if yay is already installed
if ! command -v yay &> /dev/null; then
    echo "yay not found, installing yay..."
    
    # Install yay if not found
    sudo pacman -Sy --noconfirm --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
else
    echo "yay is already installed"
fi

# Execute the remaining commands
sudo ./latest-nvidia-open.sh
sudo ./deps-ins-arch.sh

# Check if PipeWire service is enabled, and enable it if not
if ! systemctl --user is-enabled pipewire &>/dev/null; then
    echo "PipeWire service is not enabled. Enabling it now..."
    systemctl --user enable pipewire
else
    echo "PipeWire service is already enabled."
fi

# Check if PipeWire Pulse service is enabled, and enable it if not
if ! systemctl --user is-enabled pipewire-pulse.socket &>/dev/null; then
    echo "PipeWire Pulse service is not enabled. Enabling it now..."
    systemctl --user enable pipewire-pulse.socket
else
    echo "PipeWire Pulse service is already enabled."
fi

# Check if WirePlumber is installed and enabled
if ! systemctl --user is-enabled wireplumber &>/dev/null; then
    echo "WirePlumber service is not enabled. Enabling it now..."
    systemctl --user enable wireplumber
else
    echo "WirePlumber service is already enabled."
fi

# Check if PulseAudio service is enabled and disable it if needed
if systemctl --user is-enabled pulseaudio.service &>/dev/null; then
    echo "PulseAudio service is enabled. Disabling it..."
    systemctl --user disable pulseaudio.service pulseaudio.socket
else
    echo "PulseAudio service is already disabled."
fi

# Check if ly service is enabled, and enable it if not
if ! systemctl is-enabled ly.service &>/dev/null; then
    echo "'ly' service is not enabled. Enabling it now..."
    sudo systemctl enable ly.service
else
    echo "'ly' service is already enabled."
fi

./paste-dots.sh
