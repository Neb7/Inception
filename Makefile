DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml


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

up-mariadb:
	$(DOCKER_COMPOSE) up -d mariadb

up-wordpress:
	$(DOCKER_COMPOSE) up -d wordpress

up-nginx:
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

.PHONY: up down build clean fclean re init stop \
		build-mariadb build-wordpress build-nginx \
		up-mariadb up-wordpress up-nginx
