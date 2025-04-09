#!/bin/sh

echo "Running database migration."
yarn medusa db:migrate

echo "Creating admin user."
yarn medusa user --email rameshxt.1@gmail.com --password clear

echo "Starting Medusa server."
yarn start
