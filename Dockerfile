FROM circleci/php:7.0-cli-node-browsers
MAINTAINER Mike Goulding "mike@ashday.com"

RUN sudo apt-get update \
  && sudo apt-get install -y build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev \
  && sudo apt-get install libfontconfig1 libfontconfig1-dev
  
  RUN sudo apt-get install git-core
  
  # Installing npm global libraries
  RUN sudo npm install -g fs \
  && sudo npm install -g casperjs \
  && sudo npm install -g gulp
  
  # Installing terminus
  RUN cd /home/circleci/ \
  && sudo curl -O https://raw.githubusercontent.com/pantheon-systems/terminus-installer/master/builds/installer.phar \
  && sudo php installer.phar install
  
  # Updating PATH
  RUN sudo echo 'PATH="/home/circleci/vendor/bin:$PATH"' >> ~/.bashrc
