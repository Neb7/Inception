# Utilise l'image officielle Debian comme base
FROM debian:bookworm

# Installer PHP, php-fpm, et dépendances
RUN apt-get update \
	&& apt-get install -y php8.2 php-fpm php-mysql mariadb-client curl \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# On Debian Bookworm the default PHP provided is 8.2; install copies the
# generic 'php' package which maps to that version. Adjust the pool.d
# path for PHP 8.2 so the custom pool config is placed correctly.
COPY tools/www.conf /etc/php/8.2/fpm/pool.d/

EXPOSE 9000

COPY tools/wp-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-init.sh

CMD ["/usr/local/bin/wp-init.sh"]
