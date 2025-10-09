#!/bin/sh
set -e

#sleep 3600

# Exécute le script d'init SQL à chaque démarrage (ignorer les erreurs si la base existe déjà)
if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
    mariadb < /docker-entrypoint-initdb.d/init.sql || true
fi

exec "$@"
