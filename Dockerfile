FROM circleci/php:7.0-cli-node-browsers
MAINTAINER Mike Goulding "mike@ashday.com"

RUN sudo apt-get update \
  && sudo apt-get install -y build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev \
  && sudo apt-get install libfontconfig1 libfontconfig1-dev
  
  RUN sudo add-apt-repository ppa:git-core/ppa \
  && sudo apt-get update \
  && sudo apt-get install git
  
  # Installing npm global libraries
  RUN sudo npm install -g fs \
  && sudo npm install -g casperjs
  
  # Installing terminus
  RUN composer global require "pantheon-systems/terminus:^1" \
  && sudo ln -s .composer/vendor/bin/terminus /usr/bin/terminus
