#!/bin/bash

if [ ! -d /run/mysqld/ ]; then
	mkdir -p /run/mysqld
fi

chown -R mysql:mysql /run/mysqld
chmod -R 755 /run/mysqld/

if [ ! -d /var/lib/mysql/mysql ]; then
	mysql_install_db --user=$MYSQL_USER --ldata=/var/lib/mysql

	echo "FLUSH PRIVILEGES;" > /tmp/grant.sql
	echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" >> /tmp/grant.sql
	echo "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%';" >> /tmp/grant.sql
	echo "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' WITH GRANT OPTION;" >> /tmp/grant.sql
	echo "ALTER USER \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> /tmp/grant.sql
	echo "ALTER USER \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> /tmp/grant.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> /tmp/grant.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> /tmp/grant.sql
	echo "FLUSH PRIVILEGES;" >> /tmp/grant.sql

	/usr/bin/mysqld --user=$MYSQL_USER --bootstrap --skip-networking=0 < /tmp/grant.sql
	
fi

touch /tmp/fromage
chmod 755 /tmp/fromage

exec "$@"
