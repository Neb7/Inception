DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml


all: init up

init:
	mkdir -p /home/ben/data
	mkdir -p /home/ben/data/wordpress_db
	mkdir -p /home/ben/data/wordpress_site

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

.PHONY: up down build clean fclean re init stop
