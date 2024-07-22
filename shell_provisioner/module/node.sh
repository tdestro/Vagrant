#!/bin/bash

# Install nvm (Node Version Manager) for the vagrant user
sudo -i -u vagrant bash << EOF
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    # Source nvm script to make it available in the current session
    export NVM_DIR="\$([ -z "\${XDG_CONFIG_HOME-}" ] && printf %s "\${HOME}/.nvm" || printf %s "\${XDG_CONFIG_HOME}/nvm")"
    [ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"

    # Install the specific version of Node.js
    nvm install 18.17.0

    # Use the specific version of Node.js
    nvm use 18.17.0

    # Set default node version
    nvm alias default 18.17.0

    # Update node packaged modules
    npm update -g npm

    # Ensure Vagrant user can run npm
    echo 'export NVM_DIR="\$HOME/.nvm"' >> /home/vagrant/.bashrc
    echo '[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"' >> /home/vagrant/.bashrc
EOF
