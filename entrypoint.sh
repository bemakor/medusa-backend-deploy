#!/bin/sh

# TLS REJECT
export NODE_TLS_REJECT_UNAUTHORIZED=${NODE_TLS_REJECT_UNAUTHORIZED:-0}

# DB URL
DB_HOST=$(echo "$DATABASE_URL" | sed -n 's/^.*@\(.*\):5432.*$/\1/p')
echo "Database Host: $DB_HOST"

# WAIT UNTIL RDS IS READY
echo "Checking if PostgreSQL is ready at $DB_HOST:5432..."
until nc -z -v -w30 "$DB_HOST" 5432
do
  echo "Waiting for PostgreSQL at $DB_HOST:5432 to be ready..."
  sleep 5
done
echo "PostgreSQL is ready!"

echo "Running database migration.."
yarn medusa db:migrate
if [ $? -eq 0 ]; then
  echo "Database migration successful."
else
  echo "Database migration failed!"
  exit 1
fi

# Get the current minute and append it to the email
CURRENT_MINUTE=$(date +%M)
EMAIL="admin@gmail.com"

echo "Creating admin user with email: $EMAIL"
yarn medusa user --email "$EMAIL" --password admin
if [ $? -eq 0 ]; then
  echo -e "Admin user created with email: ${GREEN}$EMAIL${NC} and password: ${GREEN}admin${NC}"

else
  echo "Failed to create admin user!"
  exit 1
fi

echo "Starting Medusa server.."
yarn start
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Medusa server started successfully.${NC}"
else
  echo "Failed to start Medusa server!"
  exit 1
fi
