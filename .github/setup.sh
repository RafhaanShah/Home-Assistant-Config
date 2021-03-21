#!/bin/bash

# Runs on GitHub actions to make some changes to allow the config check to work
set -e

mv secrets_example.yaml secrets.yaml

mkdir ssl
touch ssl/fullchain.pem 
touch ssl/privkey.pem

while read -r line; do
    if [ -f "integrations/${line}" ]; then
        rm "integrations/${line}"
    fi
done <".github/custom_components.txt"
