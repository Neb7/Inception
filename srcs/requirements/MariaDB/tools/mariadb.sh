#!/bin/sh
# Start the MariaDB service (init script) so the server begins running
service mariadb start;

# Wait a few seconds for the server to fully initialize before connecting
sleep 5;

# Connect to MySQL as root and run SQL statements to create DB, user and set privileges
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Cleanly shutdown the temporary MariaDB instance after initialization
mysqladmin -u root -p"${MARIADB_ROOT_PASSWORD}" shutdown;

# Start the MariaDB server in safe mode and replace the shell process (keeps the container running)
exec mysqld_safe;
