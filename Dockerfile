FROM composer:2 AS builder

WORKDIR /app

COPY app/ /app

# Se houver composer.json no projeto
# RUN composer install --no-dev --optimize-autoloader

FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    unzip \
    && docker-php-ext-install pdo pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY --from=builder /app /var/www/html

RUN useradd -m appuser

RUN chown -R appuser:appuser /var/www/html

USER appuser

EXPOSE 80

CMD ["apache2-foreground"]