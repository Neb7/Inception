# Utilise l'image officielle Debian comme base
FROM debian:bullseye

# Installer PHP, php-fpm, et dépendances
RUN apt-get update \
	&& apt-get install -y php7.4 php-fpm php-mysql mariadb-client curl \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY tools/www.conf /etc/php/7.4/fpm/pool.d/

EXPOSE 9000

COPY tools/wp-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-init.sh

CMD ["/usr/local/bin/wp-init.sh"]



























# Installer WP-CLI
#RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#	&& chmod +x wp-cli.phar \
#	&& mv wp-cli.phar /usr/local/bin/wp

# Télécharger et installer WordPress
#WORKDIR /var/www/html
#RUN curl -O https://wordpress.org/latest.zip \
#	&& unzip latest.zip \
#	&& mv wordpress/* . \
#	&& rm -rf wordpress latest.zip


# Copier le script d'init
#COPY tools/wp-init.sh /wp-init.sh
#RUN chmod +x /wp-init.sh


# Garantir les droits d'écriture sur /var/www/html
#RUN chown -R www-data:www-data /var/www/html
#USER www-data

# Exposer le port php-fpm (par défaut 9000)
#EXPOSE 9000

#ENTRYPOINT ["/wp-init.sh"]

# Installer des extensions PHP supplémentaires si besoin
# RUN docker-php-ext-install <extension>

# Copier un php.ini personnalisé si besoin
# COPY php.ini /usr/local/etc/php/

# Définir le répertoire de travail
#WORKDIR /var/www/html

# Exposer le port php-fpm (par défaut 9000)
#EXPOSE 9000

# L'entrypoint et CMD sont déjà définis par l'image de base pour php-fpm
# Pour override :
# ENTRYPOINT ["docker-entrypoint.sh"]
# CMD ["php-fpm"]
