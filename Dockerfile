FROM php:7.3-fpm-alpine
RUN apk add --no-cache \
    zip \
    libzip-dev \
    libpng \
    libpng-dev \
    libjpeg \
    icu \
    icu-dev \
    libxml2 \
    libxml2-dev \
    git \
    openssl \
    openssl-dev 
RUN docker-php-ext-install \
    pdo_mysql \
    mysqli \
    gd \
    mbstring \
    intl \
    xml \
    opcache \
    pcntl \
    bcmath \
    zip

RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-2.7.0 \
    && docker-php-ext-enable xdebug

RUN curl -sS https://getcomposer.org/installer | php ; mv composer.phar /usr/local/bin/composer;
RUN composer global require laravel/installer

ENV PATH="/root/.composer/vendor/bin:${PATH}"

RUN composer global require hirak/prestissimo
RUN composer global require phpunit/phpunit

RUN apk add --update nodejs 
RUN apk add --update npm 
RUN apk add yarn

ADD ./docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d