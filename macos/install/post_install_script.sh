#!/bin/bash
# Post-install script for Liminal installer

# Set install directory to /Applications/Liminal.app
INSTALL_DIR="/Applications/Liminal.app"

# Ensure the liminal.zsh and server.bin scripts are executable
chmod +x "$INSTALL_DIR/Contents/MacOS/liminal.zsh"
chmod +x "$INSTALL_DIR/Contents/bin/server.bin"

exit 0