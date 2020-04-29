#!/bin/sh
set -e

mv secrets_example.yaml secrets.yaml

mkdir ssl
touch ssl/fullchain.pem 
touch ssl/privkey.pem
