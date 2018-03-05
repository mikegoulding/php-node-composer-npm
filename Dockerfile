FROM circleci/php:7.0-cli-node-browsers
MAINTAINER Mike Goulding "mike@ashday.com"

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && sudo apt update && sudo apt install -y nodejs \
  && sudo apt install -y build-essential chrpath libssl-dev libxft-dev \
  && sudo apt install libfreetype6 libfreetype6-dev \
  && sudo apt install libfontconfig1 libfontconfig1-dev \

  # composer parallel install
  && composer global require hirak/prestissimo:^0.3 \

  && docker-php-source extract \
  
  && NPROC=$(getconf _NPROCESSORS_ONLN) \

  && docker-php-ext-install -j${NPROC} gd \
        zip \

  && docker-php-source delete
  
  # Installing npm global libraries
  RUN sudo npm install -g fs \
  && sudo npm install -g casperjs
  
  # Installing terminus
  RUN composer global require "pantheon-systems/terminus:^1" \
  && ln -s .composer/vendor/bin/terminus /usr/bin/terminus
