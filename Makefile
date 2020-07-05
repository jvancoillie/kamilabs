.SILENT:
.DEFAULT_GOAL := help

SYMFONY          = bin/console
COMPOSER         = composer
YARN             = yarn
PHP              = php
COMPOSER_OPTIONS = --no-interaction --prefer-dist --optimize-autoloader

ifndef APP_ENV
	APP_ENV = dev
endif

ifneq (,$(wildcard .env.local))
	include .env.local
endif

ifdef PUBLIC_PATH
	export PUBLIC_PATH
endif

ifeq ($(APP_ENV), prod)
	COMPOSER_OPTIONS = --no-interaction --prefer-dist --optimize-autoloader --no-dev
endif

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

.DEFAULT_GOAL := help
## Help
help:
	@printf "${COLOR_COMMENT}Environment: ${APP_ENV}${COLOR_RESET}\n"
	@printf " ${COLOR_INFO}COMPOSER_OPTIONS:%-3s${COLOR_RESET} ${COMPOSER_OPTIONS} \n"
	@printf " ${COLOR_INFO}PUBLIC_PATH:%-3s${COLOR_RESET} ${PUBLIC_PATH} \n"
	@printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	@printf " make [target]\n\n"
	@printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	@awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-20s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)


## Install apps based on APP_ENV
install: build db

## Build vendor, node_modules and compile assests based on APP_ENV
build: vendor node_modules assets

.PHONY: build install

##
## Utils
## -----
##

## Create database and play migrations
db: vendor
	-$(PHP) $(SYMFONY) doctrine:database:create --if-not-exists
	$(PHP) $(SYMFONY) doctrine:migrations:migrate --no-interaction --allow-no-migration

## Reset the database
db-reset: vendor
	-$(PHP) $(SYMFONY) doctrine:database:drop --if-exists --force
	-$(PHP) $(SYMFONY) doctrine:database:create --if-not-exists
	$(PHP) $(SYMFONY) doctrine:migrations:migrate --no-interaction --allow-no-migration
	$(PHP) $(SYMFONY) doctrine:fixtures:load --no-interaction  --group=fixtures

## Generate a new doctrine migration
migration: vendor
	$(PHP) $(SYMFONY) doctrine:migrations:diff

## Run Webpack Encore to compile assets
assets: node_modules
	$(YARN) run build

## Run Webpack Encore to compile assets in dev mode
assets@dev: node_modules
	$(YARN) run dev

## Run Webpack Encore in watch mode
watch: node_modules
	$(YARN) run watch

## Clear Symfony cache
cache-clear:
	$(PHP) $(SYMFONY) cache:clear

.PHONY: db migration assets watch cache-clear

##
## Tests
## -----
##

## Run unit and functional tests
test: test-unit test-functionnal

## Run unit tests
test-unit: vendor
	$(PHP) bin/phpunit --exclude-group functional

## Run functional tests
test-functionnal: vendor
	$(PHP) bin/phpunit --group functional

.PHONY: test test-functionnal test-functionnal



# rules based on files
composer.lock: composer.json
	$(COMPOSER) update --lock $(COMPOSER_OPTIONS)

vendor: composer.lock
	$(COMPOSER) install $(COMPOSER_OPTIONS)

node_modules: yarn.lock
	$(YARN) install
	@touch -c node_modules

yarn.lock: package.json
	$(YARN) upgrade


##
## Quality assurance
## -----------------
##

## Lints twig and yaml files
lint: lt ly

lt: vendor
	$(PHP) $(SYMFONY) lint:twig templates

ly: vendor
	$(PHP) $(SYMFONY) lint:yaml config

coding-standards: vendor
	vendor/bin/phpcs -p --colors

## Validate the doctrine ORM mapping
db-validate-schema: .env vendor
	$(PHP) $(SYMFONY) doctrine:schema:validate
	e
.PHONY: lint lt ly coding-standards db-validate-schema


## deploy qualif env
deploy: cache-clear
