DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml


all: init up

init:
	mkdir -p /home/ben/data
	mkdir -p /home/ben/data/wordpress_db
	mkdir -p /home/ben/data/wordpress_site

build-mariadb:
	$(DOCKER_COMPOSE) build mariadb

build-wordpress:
	$(DOCKER_COMPOSE) build wordpress

build-nginx:
	$(DOCKER_COMPOSE) build nginx

up-mariadb:		fix-perms
				sudo rm -rf /home/ben/data/wordpress_db/*
				$(DOCKER_COMPOSE) up -d mariadb

up-wordpress:	fix-perms
				$(DOCKER_COMPOSE) up -d wordpress

up-nginx:		fix-perms
				$(DOCKER_COMPOSE) up -d nginx

up:
	$(DOCKER_COMPOSE) up --build -d

stop:
	$(DOCKER_COMPOSE) stop

down:
	$(DOCKER_COMPOSE) down

build:
	$(DOCKER_COMPOSE) build

clean:
	$(DOCKER_COMPOSE) down -v --remove-orphans

fclean: clean
	docker system prune -af

re: fclean up

fix-perms:
	sudo chown -R 999:999 /home/ben/data/wordpress_db /home/ben/data/wordpress_site
	sudo chmod -R 777 /home/ben/data/wordpress_db /home/ben/data/wordpress_site

.PHONY: up down build clean fclean re init stop \
		build-mariadb build-wordpress build-nginx \
		up-mariadb up-wordpress up-nginx fix-perms
