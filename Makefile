
DOCKER:="docker"
IMAGES:=$(shell $(DOCKER) image ls -aq)
CONTAINERS:=$(shell $(DOCKER) container ls -aq)
SHELL:=/bin/bash
.PHONY: help
help: ## Display callable targets.
	@echo "Reference card for usual actions."
	@echo "Here are available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

.PHONY: clean ## Removes all containers.
clean: ## Remove all the containers
	-docker image rm --force ${IMAGES}
	-docker container rm --force ${CONTAINERS}
	-docker system prune -a --volumes -f

.PHONY: up ## Up all containers.
up: stop rm ## Up all the containers
	docker-compose up --build --detach

.PHONY: run ## Run all containers
run: up ## Run barman container
	docker-compose run --detach

.PHONY: stop ## stop all containers
stop: ## Run barman container
	docker-compose stop

.PHONY: rm ## delete all containers
rm: ## delete all container
	docker-compose rm --force
