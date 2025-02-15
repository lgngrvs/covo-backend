# Check if the credentials file exists
CREDENTIALS_FILE="credentials"
if [[ ! -f "$CREDENTIALS_FILE" ]]; then
  echo "Credentials file not found!"
  exit 1
fi

MYSQL_ROOT_USER=$(sed -n '1p' "$CREDENTIALS_FILE" | tr -d '\r\n ')
MYSQL_ROOT_PASSWORD=$(sed -n '2p' "$CREDENTIALS_FILE" | tr -d '\r\n ')

# Automate mysql_secure_installation (code mostly from stack overflow lol)
# Make sure that NOBODY can access the server without a password
echo "updating root user"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'x';"



mysql -u "root" --password=$MYSQL_ROOT_PASSWORD -h 127.0.0.1 <<EOF
USE eventsAndSignups;
INSERT INTO events (title, description, imgurl, date) VALUES ('event title', 'event description', 'url://', '2025-02-14 23:55:00');
SELECT * FROM events;
EOF


# WARNING: THIS EXPOSES CREDENTIALS. UNSAFE FOR DEPLOYMENT
mysql -u "root" --password=$MYSQL_ROOT_PASSWORD -h 127.0.0.1 -e "SHOW DATABASES"
mysql -u "root" --password=$MYSQL_ROOT_PASSWORD -h 127.0.0.1 -e "CREATE DATABASE IF NOT EXISTS eventsAndSignups"
mysql -u "root" --password=$MYSQL_ROOT_PASSWORD -h 127.0.0.1 "eventsAndSignups" < "schema.sql"
mysql -u "root" --password=$MYSQL_ROOT_PASSWORD -h 127.0.0.1 <<EOF
USE eventsAndSignups;
INSERT INTO events (title, description, imgurl, date) VALUES ('event title', 'event description', 'url://', '2025-02-14 23:55:00');
SELECT * FROM events;
EOF