#!/bin/sh
set -e


mkdir -p /var/www/html
cd /var/www/html

# Télécharger WordPress si le dossier est vide
if [ ! -f wp-load.php ]; then
  wp core download --allow-root
fi

#echo "Variables d'environnement utilisées :"
#echo "WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME:-$MARIADB_DATABASE}"
#echo "WORDPRESS_DB_USER=${WORDPRESS_DB_USER:-$MARIADB_USER}"
#echo "WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD:-$MARIADB_PASSWORD}"
#echo "WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST:-mariadb}"
echo "ta mere0"

export WORDPRESS_DB_NAME="${WORDPRESS_DB_NAME:-$MARIADB_DATABASE}"
export WORDPRESS_DB_USER="${WORDPRESS_DB_USER:-$MARIADB_USER}"
export WORDPRESS_DB_PASSWORD="${WORDPRESS_DB_PASSWORD:-$MARIADB_PASSWORD}"
export WORDPRESS_DB_HOST="${WORDPRESS_DB_HOST:-mariadb}"

echo "ta mere1"

if [ ! -f wp-config.php ]; then
  echo "ta mere2"
  wp config create \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --allow-root
  echo "ta mere4"
fi

# Créer wp-config.php avant de vérifier la base

echo "ta mere3"

php-fpm
