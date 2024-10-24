include .env
export $(shell sed 's/=.*//' .env)

# Verificar se está no ambiente de desenvolvimento ou produção
ifeq ($(APP_ENV), production)
	DOCKER_COMPOSE_FILE := docker-compose.prod.yml
else
	DOCKER_COMPOSE_FILE := docker-compose.dev.yml
endif
setup:
	@make build
	@make up 
	@make composer-update

build:
	docker-compose -f $(DOCKER_COMPOSE_FILE) build --no-cache --force-rm

down:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

stop:
	docker-compose -f $(DOCKER_COMPOSE_FILE) stop

up:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

cli:
	docker exec -it app bash

composer-update:
	docker exec app bash -c "composer update"

data:
	docker exec app bash -c "php artisan migrate:fresh --seed"

tinker:
	docker exec -it app bash -c "php artisan tinker"
