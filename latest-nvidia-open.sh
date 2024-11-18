#!/bin/bash

# Script to autodetect NVIDIA GPU and install nvidia-open-dkms on Arch Linux
# Requires root privileges

# Function to check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root. Please use sudo."
        exit 1
    fi
}

# Function to detect NVIDIA GPU
detect_nvidia() {
    echo "Detecting NVIDIA GPU..."
    GPU_INFO=$(lspci | grep -i nvidia)
    if [[ -z "$GPU_INFO" ]]; then
        echo "No NVIDIA GPU detected."
        exit 1
    else
        echo "NVIDIA GPU detected:"
        echo "$GPU_INFO"
    fi
}

# Function to check kernel compatibility
check_kernel() {
    echo "Checking kernel version..."
    KERNEL_VERSION=$(uname -r)
    if [[ ! "$KERNEL_VERSION" =~ ^6\. ]]; then
        echo "Kernel version $KERNEL_VERSION detected. NVIDIA Open Kernel Module requires Linux kernel 6.0 or higher."
        echo "Please update your kernel before proceeding."
        exit 1
    else
        echo "Kernel version $KERNEL_VERSION is compatible."
    fi
}

# Function to install nvidia-open-dkms
install_nvidia_open() {
    echo "Updating system packages..."
    pacman -Syu --noconfirm

    echo "Installing driver dependencies (pciutils, dkms, linux-headers)..."
    pacman -S --noconfirm --needed pciutils dkms linux-headers

    echo "Installing NVIDIA Open Kernel Module (nvidia-open-dkms)..."
    pacman -S --noconfirm --needed nvidia-open-dkms nvidia-utils

    echo "Installing Vulkan support..."
    pacman -S --noconfirm --needed vulkan-tools

    echo "Rebuilding initramfs..."
    mkinitcpio -P

    echo "NVIDIA Open Kernel Module installed successfully!"
}

# Function to verify installation
verify_installation() {
    echo "Verifying NVIDIA driver installation..."
    if command -v nvidia-smi &> /dev/null; then
        echo "nvidia-smi found. Displaying GPU information:"
        nvidia-smi
    else
        echo "nvidia-smi not found. Driver installation may have failed."
        exit 1
    fi
}

# Main script execution
main() {
    check_root
    detect_nvidia
    check_kernel
    install_nvidia_open
    verify_installation
    echo "Reboot your system to apply the changes."
}

main
