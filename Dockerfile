# Установка базового образа контейнера
FROM php:8.1-apache

# Установка необходимых расширений PHP
RUN docker-php-ext-install pdo pdo_mysql

# Копирование файлов проекта в контейнер
COPY . /var/www/html

# Установка зависимостей Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Установка Composer-зависимостей проекта
RUN composer install --ignore-platform-reqs

# Установка прав на папку storage/ и bootstrap/
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap

# Указание рабочей директории
WORKDIR /var/www/html
