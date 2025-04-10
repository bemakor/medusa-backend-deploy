#!/bin/sh

# This uses the env var you defined in the ECS task
export NODE_TLS_REJECT_UNAUTHORIZED=${NODE_TLS_REJECT_UNAUTHORIZED:-0}

# Extract the hostname from the DATABASE_URL
DB_HOST=$(echo "$DATABASE_URL" | sed -n 's/^.*@\(.*\):5432.*$/\1/p')

# Wait for RDS to be available before continuing
until nc -z -v -w30 "$DB_HOST" 5432
do
  echo "⏳ Waiting for PostgreSQL at $DB_HOST:5432 to be ready..."
  sleep 5
done

echo "🚀 Running database migration..."
yarn medusa db:migrate

echo "👤 Creating admin user..."
yarn medusa user --email rameshxt.1@gmail.com --password clear

echo "🟢 Starting Medusa server..."
yarn start
