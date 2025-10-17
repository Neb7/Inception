FROM debian:bookworm

# Install PHP, php-fpm, and dependencies
RUN apt-get update \
	&& apt-get install -y php8.2 php-fpm php-mysql mariadb-client curl \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Ensure custom php-fpm pool config is placed for PHP 8.2 on Debian Bookworm
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/

# Expose PHP-FPM port
EXPOSE 9000

# Copy initialization script and make it executable
COPY tools/wp-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-init.sh

# Start WordPress initialization script as the container command
CMD ["/usr/local/bin/wp-init.sh"]
