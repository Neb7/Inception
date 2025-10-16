FROM debian:bookworm

# Update package lists, install MariaDB server, and clean apt cache to reduce image size
RUN apt-get update \
	&& apt-get install -y mariadb-server \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy custom MariaDB server configuration into the container
COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/

# Expose the default MariaDB port
EXPOSE 3306

# Copy the MariaDB startup script into the container
COPY ./tools/mariadb.sh /usr/local/bin/

# Make the startup script executable
RUN chmod +x /usr/local/bin/mariadb.sh

# Run the MariaDB startup script when the container starts
CMD ["/usr/local/bin/mariadb.sh"]
