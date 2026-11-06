NAME = inception

all: up

up:
	mkdir -p /home/aarab/data/mariadb
	mkdir -p /home/aarab/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a -f

fclean: clean
	sudo rm -rf /home/aarab/data/mariadb/*
	sudo rm -rf /home/aarab/data/wordpress/*
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true

re: fclean all

.PHONY: all up down clean fclean re
