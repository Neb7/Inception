#!/bin/sh
set -e

# Attendre que la base soit prête
until wp db check --allow-root; do
  sleep 2
done

if ! wp core is-installed --allow-root; then
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
