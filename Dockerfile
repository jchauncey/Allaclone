FROM php:7.4-apache
COPY . /var/www/html/

RUN apt update && \
  apt install -y wget gnupg lsb-release && \
  wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - && \
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list && \
  apt update && \
  apt install -y php7.4-common/bullseye php7.4-mysql/bullseye && \
  docker-php-ext-install mysqli


WORKDIR /var/www/html/
RUN cp includes/config.docker.php includes/config.php
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
# RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
