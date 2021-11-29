include .env 


kill:
	@./scripts/kill.sh

## up		:	Build and Start up containers.
.PHONY: install
install:
	@./scripts/install.sh
	@make info

## up		:	Build and Start up containers.
.PHONY: up
up:
	@echo "Building and Starting up containers for $(PROJECT_NAME)..."
	docker-compose build --pull
	docker-compose up -d --remove-orphans
	@make info

## start		:	Start up containers.
.PHONY: start
start:
	@echo "Starting containers for $(PROJECT_NAME)..."
	@docker-compose start
	@make info

## prune		:	Remove containers and their volumes.
##			You can optionally pass an argument with the service name to prune single container
##			prune on.website	: Prune `on.website` container and remove its volumes.
##			prune on.website on.phpmyadmin 	: Prune `on.website` and `on.phpmyadmin` containers and remove their volumes.
.PHONY: prune
prune:
	@echo "Removing containers for $(PROJECT_NAME)..."
	@docker-compose down -v $(filter-out $@,$(MAKECMDGOALS))

## stop		:	Stop containers.
.PHONY: stop
stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker-compose stop

.PHONY: down
down: stop

## shell		:	Access `api` container via shell.
##			You can optionally pass an argument with a service name to open a shell on the specified container
.PHONY: shell
shell:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='$(PROJECT_NAME).$(or $(filter-out $@,$(MAKECMDGOALS)), 'api')' --format "{{ .ID }}") bash

## logs		:	View containers logs.
##			You can optionally pass an argument with the service name to limit logs
.PHONY: logs
logs:
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))
