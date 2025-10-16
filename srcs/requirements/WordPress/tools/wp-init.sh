#!/bin/sh
# Ensure WordPress directory exists and switch to it
mkdir -p /var/www/wordpress
cd /var/www/wordpress

# Install WP-CLI if it's not already present
if [ ! -f /usr/local/bin/wp ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
fi

# Download WordPress core and create wp-config.php using environment variables if missing
if [ ! -f wp-config.php ]; then
	wp core download --allow-root

	mv wp-config-sample.php wp-config.php
	sed -i "s|database_name_here|${MARIADB_DATABASE}|" wp-config.php
	sed -i "s|username_here|${MARIADB_USER}|" wp-config.php
	sed -i "s|password_here|${MARIADB_PASSWORD}|" wp-config.php
	sed -i "s|localhost|mariadb|" wp-config.php
fi

# Wait briefly for the database service to become available
echo "Waiting for database connection..."
sleep 10

# Install WordPress core and create admin/user accounts if not already installed
if ! wp core is-installed --allow-root; then
	wp core install \
		--url="${DOMAIN_NAME}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--skip-email \
		--allow-root

	wp user create \
		"${WP_USER}" "${WP_USER_EMAIL}" \
		--user_pass="${WP_USER_PASSWORD}" \
		--role=editor \
		--allow-root
fi

# Ensure the twentytwentyfour theme is installed and activated
if ! wp theme is-installed twentytwentyfour --allow-root; then
	wp theme install twentytwentyfour --activate --allow-root
else
	wp theme activate twentytwentyfour --allow-root
fi

# Prepare PHP-FPM runtime directory and start PHP-FPM in the foreground
mkdir -p /run/php
echo "Starting PHP-FPM..."

php-fpm8.2 -F
