#syntax=docker/dockerfile:1.4

FROM php:7.2-fpm

# Installer les dépendances
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN set -eux; \
	install-php-extensions \
        pdo_mysql \
		@composer \
		apcu \
		intl \
		opcache \
		zip \
	;

# Définir le répertoire de travail
WORKDIR /app