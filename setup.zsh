#!/bin/zsh
# init_db.zsh - Automatic MySQL database and user initialization
# This script reads credentials from a file called "credentials"
# The expected format is:
# Line 1: MySQL root username
# Line 2: MySQL root password
# Line 3: Desired admin username
# Line 4: Desired admin password

CREDENTIALS_FILE="credentials"

# Check if the credentials file exists
if [[ ! -f "$CREDENTIALS_FILE" ]]; then
  echo "Credentials file not found!"
  exit 1
fi

# Read credentials from file and trim whitespace/newlines
MYSQL_ROOT_USER=$(sed -n '1p' "$CREDENTIALS_FILE" | tr -d '\r\n ')
MYSQL_ROOT_PASSWORD=$(sed -n '2p' "$CREDENTIALS_FILE" | tr -d '\r\n ')
MYSQL_ADMIN_USER=$(sed -n '3p' "$CREDENTIALS_FILE" | tr -d '\r\n ')
MYSQL_ADMIN_PASSWORD="x"

# Configuration variables
MYSQL_HOST="127.0.0.1"           # Typically 127.0.0.1 to force a TCP connection
DATABASE="eventsAndSignups"      # The name of your database
SCHEMA_FILE="schema.sql"         # Path to your SQL schema file

echo "Using MySQL root user: $MYSQL_ROOT_USER"
echo "Using MySQL admin user: $MYSQL_ADMIN_USER"

echo "Creating database '$DATABASE' if it doesn't exist..."
mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" -h "$MYSQL_HOST" \
  -e "CREATE DATABASE IF NOT EXISTS \`${DATABASE}\`;"

echo "Creating user '$MYSQL_ADMIN_USER' if it doesn't exist..."
mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" -h "$MYSQL_HOST" \
  -e "CREATE USER IF NOT EXISTS '$MYSQL_ADMIN_USER'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ADMIN_PASSWORD';"

echo "Granting privileges to '$MYSQL_ADMIN_USER' on database '$DATABASE'..."
mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" -h "$MYSQL_HOST" \
  -e "GRANT ALL PRIVILEGES ON \`${DATABASE}\`.* TO '$MYSQL_ADMIN_USER'@'localhost';"
mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" -h "$MYSQL_HOST" \
  -e "FLUSH PRIVILEGES;"

echo "Applying schema from '$SCHEMA_FILE'..."
mysql -u"$MYSQL_ADMIN_USER" -p"$MYSQL_ADMIN_PASSWORD" -h "$MYSQL_HOST" "$DATABASE" < "$SCHEMA_FILE"

echo "Database initialization completed."
