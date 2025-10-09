
FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y mariadb-server mariadb-client vim \
	&& apt-get clean

RUN mkdir -p /run/mysqld /docker-entrypoint-initdb.d/ \
	&& chown -R mysql:mysql /run/mysqld /docker-entrypoint-initdb.d/ \
	&& chmod 777 /run/mysqld /docker-entrypoint-initdb.d/

# Copie le script d'init SQL
COPY tools/init.sql /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sql

COPY tools/mariadb.conf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

COPY ./tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh


ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

# repasser sur le user mysql
USER root
CMD ["mysqld", "--bind-address=0.0.0.0"]
