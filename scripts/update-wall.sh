# Move and rename your wallpaper to ~/.river

#!/bin/bash

# Ensure file path is provided
if [ -z "$1" ]; then
    echo "No wallpaper file provided"
    exit 1
fi

# Verify the file exists in the current directory
if [ ! -f "$(pwd)/$1" ]; then
    echo "File not found: $(pwd)/$1"
    exit 1
fi

cp $(pwd)/$1 ~/.river
echo "Setting up the wall for you..."
pkill swaybg; riverctl spawn 'swaybg -i ~/.river -m fill'
