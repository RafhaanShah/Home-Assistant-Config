#!/bin/bash

# Runs on GitHub actions to make some changes to allow the config check to work
set -e

# Set secrets file
mv secrets_example.yaml secrets.yaml

# Add fake ssl files
mkdir ssl
touch ssl/fullchain.pem 
touch ssl/privkey.pem

# Remove custom_components config files
while read -r line; do
    if [ -f "integrations/${line}" ]; then
        rm "integrations/${line}"
    fi
done <".github/custom_components.txt"
