#!/bin/sh
set -e


mkdir -p /var/www/html
cd /var/www/html

# Télécharger WordPress si le dossier est vide
if [ ! -f wp-load.php ]; then
  wp core download --allow-root
fi

echo "Variables d'environnement utilisées :"
echo "WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME:-$MARIADB_DATABASE}"
echo "WORDPRESS_DB_USER=${WORDPRESS_DB_USER:-$MARIADB_USER}"
echo "WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD:-$MARIADB_PASSWORD}"
echo "WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST:-mariadb:3306}"
echo "ta mere0"

export WORDPRESS_DB_NAME="${WORDPRESS_DB_NAME:-$MARIADB_DATABASE}"
export WORDPRESS_DB_USER="${WORDPRESS_DB_USER:-$MARIADB_USER}"
export WORDPRESS_DB_PASSWORD="${WORDPRESS_DB_PASSWORD:-$MARIADB_PASSWORD}"
export WORDPRESS_DB_HOST="${WORDPRESS_DB_HOST:-mariadb:3306}"

echo "ta mere1"

# Attendre que la base soit prête
until wp db check --allow-root; do
  sleep 2
done

echo "ta mere2"

if ! wp core is-installed --allow-root; then
  echo "ta mere5"
  echo "UID/GID courant : $(id -u)/$(id -g)"
  echo "Droits du dossier /var/www/html :"
  ls -ld /var/www/html
  echo "Contenu du dossier /var/www/html :"
  ls -la /var/www/html
  echo "Tentative de création de wp-config.php..."
  wp config create \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --allow-root
  status=$?
  if [ $status -ne 0 ]; then
    echo "Échec de la création de wp-config.php (code $status) :"
    ls -l
    echo "Contenu du dossier :"
    ls -la
    echo "Diagnostic WP-CLI :"
    wp config create \
      --dbname="$WORDPRESS_DB_NAME" \
      --dbuser="$WORDPRESS_DB_USER" \
      --dbpass="$WORDPRESS_DB_PASSWORD" \
      --dbhost="$WORDPRESS_DB_HOST" \
      --allow-root --debug
    exit 1
  fi

  echo "ta mere4"
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

echo "ta mere3"

php-fpm
