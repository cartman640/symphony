FROM php:5-apache

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y unzip libxslt1.1 libxslt1-dev --no-install-recommends && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli xsl
RUN a2enmod rewrite

ADD http://www.getsymphony.com/download/releases/current/ /symphony.zip

RUN unzip /symphony.zip -d /var/www/html && \
    mv /var/www/html/symphony-2.6.11/* /var/www/html/. && \
    rm -rf /var/www/html/symphony-2.6.11 && \
    chown -R www-data:www-data /var/www/html/*

EXPOSE 80