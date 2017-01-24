FROM php:7.1-fpm-alpine

# Install the PHP extensions we need
RUN apk add --no-cache --virtual .phpext-build-deps \
      autoconf gcc libc-dev make libpng-dev libjpeg-turbo-dev freetype-dev \
    && docker-php-ext-configure gd \
        --with-png-dir=/usr \
        --with-jpeg-dir=/usr \
        --with-freetype-dir=/usr \
    && docker-php-ext-install gd mysqli opcache \
    && find /usr/local/lib/php/extensions -name '*.a' -delete \
    && find /usr/local/lib/php/extensions -name '*.so' -exec strip --strip-all '{}' \; \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local/lib/php/extensions \
          | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
          | sort -u \
          | xargs -r apk info --installed \
          | sort -u \
        )" \
    && echo $runDeps \
    && apk add --virtual .phpext-run-deps $runDeps \
    && apk del .phpext-build-deps

# Install Composer
RUN set -x \
    && curl -o composer-setup.php -fSL "https://getcomposer.org/installer" \
    && php -r "return '`curl -fSL "https://composer.github.io/installer.sig"`' === hash_file('SHA384', 'composer-setup.php');" \
    && php composer-setup.php --quite --install-dir=/usr/local/sbin --filename=composer \
    && rm composer-setup.php

# Install wp-cli
RUN set -x \
    && curl -o /usr/local/sbin/wp -fSL "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar" \
    && chmod +x /usr/local/sbin/wp

# https://wordpress.org/download/release-archive/
ARG WORDPRESS_VERSION=4.7.1
ARG WORDPRESS_SHA1=8e56ba56c10a3f245c616b13e46bd996f63793d6

# Download Current Version of Wordpress
RUN set -x \
    && mkdir -p /var/www/html/public \
    && curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz" \
    && echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
    # upstream tarballs include ./wordpress/ so this gives us /var/www/html/public/wordpress
    && tar -xzf wordpress.tar.gz -C /var/www/html/public \
    && rm wordpress.tar.gz \
    # lets shorten the folder name
    && mv /var/www/html/public/wordpress /var/www/html/public/wp \
    && chown -R www-data:www-data /var/www/html

# Copy all needed files
COPY /files/ /
RUN chmod u+x /usr/local/bin/docker-entrypoint.sh

VOLUME /var/www/html

# ENTRYPOINT resets CMD
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
