FROM alpine:3.18

RUN apk update

RUN apk add wget php81 php81-fpm php81-mysqli mariadb-client php81-phar php81-intl php81-mbstring

RUN wget https://fr.wordpress.org/wordpress-6.4.2-fr_FR.tar.gz -P /var/www/html

RUN cd /var/www/html && tar -xzf wordpress-6.4.2-fr_FR.tar.gz && rm -rf wordpress-6.4.2-fr_FR.tar.gz

RUN adduser -D -H -G www-data www-data

RUN chown -R www-data:www-data /var/www/html

RUN chmod 755 /var/www/html

COPY --chmod=755 conf/php-fpm.conf /etc/php81/php-fpm.conf

COPY --chmod=755 conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY --chmod=755 tools/config.sh /

EXPOSE 9000

ENTRYPOINT ["sh", "config.sh"]

CMD ["/usr/sbin/php-fpm81", "-F", "-R"]
