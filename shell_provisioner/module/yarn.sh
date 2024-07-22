#!/bin/bash

# Install nvm (Node Version Manager) for the vagrant user
sudo -i -u vagrant bash << 'EOF'
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    # Source nvm script to make it available in the current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Install the specific version of Node.js
    nvm install 18.17.0

    # Use the specific version of Node.js
    nvm use 18.17.0

    # Set default node version
    nvm alias default 18.17.0

    # Update node packaged modules
    npm update -g npm

    # Install yarn globally
    npm install -g yarn

    # Navigate to the Sylius project directory
    cd /var/www/sites/Sylius

    # Install yarn dependencies and build the project
    yarn install
    yarn build

    # Copy the JSON configuration file
    cp /var/www/sites/Sylius/dockerincludes/DestroMachinesStore-965e04f545e7.json /var/www/sites/Sylius/DestroMachinesStore-965e04f545e7.json

    # Run composer install with the necessary environment variables
    COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_PROCESS_TIMEOUT=2000 composer install --prefer-dist

    # Verify yarn installation
    which yarn

EOF
