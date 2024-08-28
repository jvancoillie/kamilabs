.SILENT:
.DEFAULT_GOAL := help

# Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

# Variables
DOCKER_COMPOSE = docker compose

##—— Makefile —————————————————————————————————————————————————————————————————————————————————————————————————————————

# Help target to display help screen
help: ## Outputs this help screen
	@printf "${COLOR_COMMENT}Makefile Targets:${COLOR_RESET}\n"
	@grep -E '(^[a-zA-Z0-9\.@_-]+:.*?##.*$$)|(^##)' $(firstword  $(MAKEFILE_LIST)) \
		| awk 'BEGIN {FS = ":.*?## "}{printf "${COLOR_INFO}%-30s${COLOR_RESET} %s\n", $$1, $$2}' \
		| sed -e 's/\[32m##/[33m/'

# Build or rebuild services
.PHONY: build
build: ## Build or rebuild services
	$(DOCKER_COMPOSE) build

# Start services
.PHONY: up
up: ## Start services
	$(DOCKER_COMPOSE) up -d --remove-orphans

# Stop services
.PHONY: down
down: ## Stop services
	$(DOCKER_COMPOSE) down

# Restart services
.PHONY: restart
restart: ## Restart services
	$(MAKE) down
	$(MAKE) up

# View logs
.PHONY: logs
logs: ## View logs
	$(DOCKER_COMPOSE) logs -f

.PHONY: shell
shell: ## Open a shell in the Symfony app container
	$(DOCKER_COMPOSE) exec php sh

# Execute a command in the Symfony app container
.PHONY: exec
exec: ## Execute a command in the Symfony app container
	$(DOCKER_COMPOSE) exec php $(cmd)