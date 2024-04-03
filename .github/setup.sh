#!/bin/bash

# Runs on GitHub actions to make some changes to allow the config check to work
set -e

# Set secrets file
mv secrets_example.yaml secrets.yaml

# Add fake ssl files
mkdir -p ssl
touch ssl/fullchain.pem 
touch ssl/privkey.pem

# Add fake Google service file
touch SERVICE_ACCOUNT.JSON

# Remove custom_components integration config files
while read -r line; do
    if [ -f "integrations/${line}" ]; then
        rm "integrations/${line}"
    fi
done <".github/custom_components.txt"

# Remove other custom_components outside integrations
CUSTOM_COMPONENTS=(
    "entities/sensor/weather_illuminance.yaml"
)

for CC in "${CUSTOM_COMPONENTS[@]}"; do
    if [ -f "${CC}" ]; then
        rm "${CC}"
    fi
done
