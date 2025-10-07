
FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y mariadb-server \
	&& apt-get clean \

RUN mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld
	&& chmod 777 /run/mysqld

# Copie le script d'init SQL
COPY tools/init.sql /docker-entrypoint-initdb.d/init.sql
RUN chmod +x /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306



USER mysql
CMD ["mysqld"]
