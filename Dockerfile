FROM php:7.2
MAINTAINER Mike Goulding "mike@ashday.com"

RUN apt update && apt install -y \
        git \
        jq \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmemcached-dev \
        libpng-dev \
        gnupg \
        build-essential \
        zlib1g-dev \

  # node & npm
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt update && apt install -y nodejs \
  && apt install -y build-essential chrpath libssl-dev libxft-dev \
  && apt install libfreetype6 libfreetype6-dev \
  && apt install libfontconfig1 libfontconfig1-dev \

  # composer
  && curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
  && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
  && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
  && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
  && rm -f /tmp/composer-setup.* \

  # composer parallel install
  && composer global require hirak/prestissimo:^0.3 \

  && docker-php-source extract \
  
  && NPROC=$(getconf _NPROCESSORS_ONLN) \

  && docker-php-ext-install -j${NPROC} gd \
        zip \

  && docker-php-source delete
  
  # Installing npm global libraries
  RUN npm install -g fs \
  && npm install -g casperjs
  
  RUN export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64" \
  && wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 \
  && tar xvjf $PHANTOM_JS.tar.bz2 \
  && mv $PHANTOM_JS /usr/local/share \
  && ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin
  
  # Installing terminus
  RUN composer global require "pantheon-systems/terminus:^1" \
  && ln -s .composer/vendor/bin/terminus /usr/bin/terminus
