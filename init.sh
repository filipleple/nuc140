#!/bin/bash
set -e

# Check if name provided
if [ $# -ne 1 ]; then
    echo "Usage: ./init.sh YourProjectName"
    exit 1
fi

TEMPLATE=FirstExample
NEW_PROJECT=$1

# Check if project already exists
if [ -d "$NEW_PROJECT" ]; then
    echo "Error: '$NEW_PROJECT' already exists."
    exit 1
fi

echo "[*] Creating new project: $NEW_PROJECT"
cp -r "$TEMPLATE" "$NEW_PROJECT"

# Clean up old artifacts in Build dir
BUILD_DIR="$NEW_PROJECT/Build"
if [ -d "$BUILD_DIR" ]; then
    echo "[*] Cleaning leftover build artifacts..."
    find "$BUILD_DIR" -type f \( -name "*.hex" -o -name "*.elf" -o -name "*.map" \) -exec rm -f {} +
fi

echo "[✓] Project '$NEW_PROJECT' created. You can now build it with:"
echo "    ./build.sh $NEW_PROJECT"
