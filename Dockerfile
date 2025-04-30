FROM php:8.1-apache

# Install PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git libonig-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Enable Apache Rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy app files
COPY . /var/www/html

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

# Apache config for Yii2 (override default)
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/web|' /etc/apache2/sites-enabled/000-default.conf
