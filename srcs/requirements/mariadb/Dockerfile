FROM alpine:3.18

RUN apk update

RUN apk add mariadb mariadb-server-utils mariadb-client openrc mysql mysql-client

COPY --chmod=755 conf/50-server.cnf /etc/my.cnf.d/50-server.cnf

COPY --chmod=755 tools/mysql_s.sh /

EXPOSE 3306

ENTRYPOINT ["sh", "mysql_s.sh"]

CMD ["/usr/bin/mysqld", "--user=mysql", "--bind-address=0.0.0.0", "--skip-networking=0"]
