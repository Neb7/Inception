#!/bin/sh
mkdir -p /var/www/wordpress
cd /var/www/wordpress

if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f wp-config.php ]; then
    wp core download --allow-root

    mv wp-config-sample.php wp-config.php
    sed -i "s|database_name_here|${MARIADB_DATABASE}|" wp-config.php
    sed -i "s|username_here|${MARIADB_USER}|" wp-config.php
    sed -i "s|password_here|${MARIADB_PASSWORD}|" wp-config.php
    sed -i "s|localhost|mariadb|" wp-config.php
fi

echo "Waiting for database connection..."
sleep 10

if ! wp core is-installed --allow-root; then
#    if [[ "${WP_ADMIN_USER}" =~ [Aa]dmin|[Aa]dministrator ]]; then
#        echo "Error: Administrator username cannot contain 'admin', 'Admin', or 'administrator' ..."
#        exit 1
#    fi

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

if ! wp theme is-installed twentytwentyfour --allow-root; then
    wp theme install twentytwentyfour --activate --allow-root
else
    wp theme activate twentytwentyfour --allow-root
fi

mkdir -p /run/php
echo "Starting PHP-FPM..."
php-fpm7.4 -F

















































#set -e


#mkdir -p /var/www/html
#cd /var/www/html

# Télécharger WordPress si le dossier est vide
#if [ ! -f wp-load.php ]; then
#  wp core download --allow-root
#fi

#echo "Variables d'environnement utilisées :"
#echo "WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME:-$MARIADB_DATABASE}"
#echo "WORDPRESS_DB_USER=${WORDPRESS_DB_USER:-$MARIADB_USER}"
#echo "WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD:-$MARIADB_PASSWORD}"
#echo "WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST:-mariadb}"
#echo "ta mere0"

# export WORDPRESS_DB_NAME="${WORDPRESS_DB_NAME:-$MARIADB_DATABASE}"
# export WORDPRESS_DB_USER="${WORDPRESS_DB_USER:-$MARIADB_USER}"
# export WORDPRESS_DB_PASSWORD="${WORDPRESS_DB_PASSWORD:-$MARIADB_PASSWORD}"
# export WORDPRESS_DB_HOST="${WORDPRESS_DB_HOST:-mariadb}"

#echo "ta mere1"

#if [ ! -f wp-config.php ]; then
#  echo "ta mere2"
#  wp config create \
#    --dbname="$WORDPRESS_DB_NAME" \
#    --dbuser="$WORDPRESS_DB_USER" \
#    --dbpass="$WORDPRESS_DB_PASSWORD" \
#    --dbhost="$WORDPRESS_DB_HOST" \
#    --allow-root
#  echo "ta mere4"
#fi

# Créer wp-config.php avant de vérifier la base

#echo "ta mere3"

#php-fpm
