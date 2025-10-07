
FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y mariadb-server \
	&& apt-get clean \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld

# Copie le script d'init SQL
COPY tools/init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306

USER mysql
CMD ["mysqld"]
