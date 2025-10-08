#!/bin/sh
set -e

# Exécute le script d'init SQL à chaque démarrage (ignorer les erreurs si la base existe déjà)
if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
    mariadb < /docker-entrypoint-initdb.d/init.sql || true
fi

exec mysqld --bind-address=0.0.0.0
