#!/bin/bash

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod 755 wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html/wordpress

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	wp core config --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost='mariadb:3306' --dbprefix='wp_'

	wp core install --url="https://${DOMAIN_NAME}" --title="${DOMAIN_NAME}" --admin_user="${WORDPRESS_ROOT}" --admin_password="${WORDPRESS_R_PASSWORD}" --admin_email="${WORDPRESS_ROOT}@gmail.com"

	wp user create ${WORDPRESS_USER} ${WORDPRESS_USER}@gmail.com --user_pass="${WORDPRESS_PASSWORD}"
fi

if [ -f /var/www/html/wordpress/wp-config-sample.php ]; then
	rm -rf /var/www/html/wordpress/wp-config-sample.php
fi

#script end = print last cmd = ok
echo "$@"
#if CMD in Dockerfile allows to exec without error
exec "$@"
