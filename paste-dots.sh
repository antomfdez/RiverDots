#!/bin/bash

# Check if starship is installed
if ! command -v starship &>/dev/null; then
    echo "Starship is not installed. Please install it first."
    exit 1
fi

# Get the current shell
SHELL_NAME=$(basename "$SHELL")

# Function to add the line to a shell config file if not already present
add_to_config() {
    local config_file=$1
    local shell_init_line="eval \"\$(starship init $SHELL_NAME)\""

    # Check if the line is already in the config file
    if grep -qF "$shell_init_line" "$config_file"; then
        echo "Starship initialization already exists in $config_file"
    else
        echo "$shell_init_line" >> "$config_file"
        echo "Added Starship initialization to $config_file"
    fi
}

# Add the Starship initialization to the appropriate config file based on the shell
case "$SHELL_NAME" in
    bash)
        add_to_config "$HOME/.bashrc"
        ;;
    zsh)
        add_to_config "$HOME/.zshrc"
        ;;
    fish)
        add_to_config "$HOME/.config/fish/config.fish"
        ;;
    *)
        echo "Unsupported shell: $SHELL_NAME"
        exit 1
        ;;
esac

echo "Starship setup complete for $SHELL_NAME"


# Paste dots/
mkdir ~/.config/foot 2>/dev/null
mkdir ~/.config/rofi 2>/dev/null
mkdir ~/.config/i3status-rust 2>/dev/null
mkdir ~/.config/i3bar-river 2>/dev/null
mkdir ~/.config/river 2>/dev/null
cp -r ./dots/* ~/.config/
cp -r ./scripts/* ~/scripts/
cp ./repo-assets/wall ~/.river

echo -e "\e[32mDots applied :) have a great day...\e[0m"

echo -e "\e[33mPlease reboot your system to apply the changes\e[0m"
