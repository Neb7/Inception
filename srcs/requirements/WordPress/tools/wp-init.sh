#!/bin/sh
set -e

# Exporter les variables pour WP-CLI
export WORDPRESS_DB_NAME="${WORDPRESS_DB_NAME:-$MARIADB_DATABASE}"
export WORDPRESS_DB_USER="${WORDPRESS_DB_USER:-$MARIADB_USER}"
export WORDPRESS_DB_PASSWORD="${WORDPRESS_DB_PASSWORD:-$MARIADB_PASSWORD}"
export WORDPRESS_DB_HOST="${WORDPRESS_DB_HOST:-mariadb:3306}"

# Attendre que la base soit prête
until wp db check --allow-root; do
  sleep 2
done

if ! wp core is-installed --allow-root; then
  wp config create \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --allow-root

  wp core install \
    --url="$DOMAIN_NAME" \
    --title="${WP_TITLE:-MonSite}" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email \
    --allow-root

  wp user create "$WP_USER2" "$WP_USER2_EMAIL" --role=author --user_pass="$WP_USER2_PASSWORD" --allow-root
fi

php-fpm
