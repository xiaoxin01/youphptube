FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    apt-get update && \
    apt-get install -y --no-install-recommends apache2 php libapache2-mod-php php-mysql php-curl php-gd php-intl mysql-server mysql-client ffmpeg git libimage-exiftool-perl

RUN apt-get install -y --no-install-recommends ca-certificates && \
    cd /var/www/html && \
    git clone https://github.com/DanielnetoDotCom/YouPHPTube.git && \
    cd /var/www/html && \
    git clone https://github.com/DanielnetoDotCom/YouPHPTube-Encoder.git

RUN apt-get install -y --no-install-recommends python curl && \
    curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && \
    chmod a+rx /usr/local/bin/youtube-dl && \
    a2enmod rewrite

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR=/var/www/html

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
