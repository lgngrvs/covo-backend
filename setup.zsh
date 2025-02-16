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
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

# WARNING: THIS EXPOSES CREDENTIALS. UNSAFE FOR DEPLOYMENT
mysql -u "root" --password=$MYSQL_ROOT_PASSWORD -h 127.0.0.1 -e "SHOW DATABASES"
mysql -u "root" --password=$MYSQL_ROOT_PASSWORD -h 127.0.0.1 -e "CREATE DATABASE IF NOT EXISTS eventsAndSignups"
mysql -u "root" --password=$MYSQL_ROOT_PASSWORD -h 127.0.0.1 "eventsAndSignups" < "schema.sql"
mysql -u "root" --password=$MYSQL_ROOT_PASSWORD -h 127.0.0.1 <<EOF
USE eventsAndSignups;
INSERT INTO events (title, date, location, description, imgurl) VALUES 
('fake event title', '2025-02-14 23:55:00', 'fake location', 'fake event description', "h"),
('Treehacks', "2025-02-15 12:00:00", 'Huang', "get hackin", "h"),
("Slecture", "2025-02-14 12:00:00", "Slounge", "Knowledge", "h"),
("Dinner", "2025-02-13 17:00:00", "Flomo", "food", "h"),
("WOW IT WORKS!", "2025-02-13 17:00:00", "WAHOOO", "WEEE", "YEYA");
SELECT * FROM events;
EOF