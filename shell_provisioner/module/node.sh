#!/bin/bash

# Install nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Source nvm script to make it available in the current session
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install the specific version of Node.js
nvm install 18.17.0

# Use the specific version of Node.js
nvm use 18.17.0

# Alternatively, to install the latest release that's greater than or equal to 20.5.0, you can use:
# nvm install --lts

# Update node packaged modules
npm update -g npm
