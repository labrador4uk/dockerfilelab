
FROM ubuntu:16.04

EXPOSE 80

RUN apt update \
 && apt -y install apache2

RUN service apache2 start

RUN echo mysql-server mysql-server/root_password password 1234 | debconf-set-selections \
 && echo mysql-server mysql-server/root_password_again password 1234 | debconf-set-selections \
 && apt -y install mysql-server

RUN apt update \
 && apt -y install php libapache2-mod-php php-mcrypt php-mysql \
 && service apache2 restart \

RUN echo '<?php   phpinfo();  ?>' > /var/www/html/info.php
