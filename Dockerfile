FROM circleci/php:7.0-cli-node-browsers
MAINTAINER Mike Goulding "mike@ashday.com"

RUN sudo apt-get update \
  && sudo apt-get install -y build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev \
  && sudo apt-get install libfontconfig1 libfontconfig1-dev
  
  RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24
  RUN cat > /etc/apt/sources.list.d/git.list << EOF \
  deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu precise main \
  EOF 
  
  RUN sudo apt-get install software-properties-common python-software-properties \
  && sudo apt-get update \
  && sudo apt-get build-dep git \
  && sudo apt-get -b source git \
  && sudo dpkg -i git_*.deb git-man_*.deb \
  && sudo dpkg -P git-core
  
  # Installing npm global libraries
  RUN sudo npm install -g fs \
  && sudo npm install -g casperjs
  
  # Installing terminus
  RUN composer global require "pantheon-systems/terminus:^1" \
  && sudo ln -s .composer/vendor/bin/terminus /usr/bin/terminus
