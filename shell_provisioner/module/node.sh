#!/bin/bash

# Install node.js
curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get install -y nodejs

# Update node packaged modules
npm update -g npm