FROM php:8.1-fpm

   WORKDIR /var/www/

   RUN apt-get update && apt-get install -y \
       curl \
       libpng-dev \
       libonig-dev \
       libxml2-dev \
       zip \
       unzip \
       && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

   RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

   COPY . .

   RUN composer install

   RUN cp .env.example .env
   RUN php artisan key:generate

   RUN php artisan optimize

   EXPOSE 9000

   CMD ["php-fpm"]
