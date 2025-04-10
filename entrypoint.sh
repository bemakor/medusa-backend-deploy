#!/bin/sh

# TLS REJECT
export NODE_TLS_REJECT_UNAUTHORIZED=${NODE_TLS_REJECT_UNAUTHORIZED:-0}

# DB URL
DB_HOST=$(echo "$DATABASE_URL" | sed -n 's/^.*@\(.*\):5432.*$/\1/p')

# WAIT UNTILL RDS IS READY
until nc -z -v -w30 "$DB_HOST" 5432
do
  echo "Waiting for PostgreSQL at $DB_HOST:5432 to be ready.."
  sleep 5
done

echo "Running database migration.."
yarn medusa db:migrate

echo "Creating admin user.."
yarn medusa user --email admin@gmail.com --password admin

echo "Starting Medusa server.."
yarn start
