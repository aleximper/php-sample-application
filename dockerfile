FROM composer:lts as deps

WORKDIR /app

FROM php:7.1.33-apache as final
#Install dependences
RUN apt-get update && apt-get install unzip zlib1g zlib1g-dev
RUN docker-php-ext-install pdo_mysql zip

# Set php ini prod
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Create path apache
RUN mkdir -p /var/www/html/config

# Copy files
COPY --from=deps /usr/bin/composer /usr/bin/composer
COPY etc/php-sample.conf /etc/apache2/sites-available/
COPY config-dev/ /var/www/html/config/
COPY . .

#Config apache
RUN a2enmod rewrite
RUN a2ensite  php-sample.conf
RUN a2dissite 000-default.conf

#env execution composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer update
RUN composer dump-autoload
RUN chmod -R 777 /var/www/html
USER www-data