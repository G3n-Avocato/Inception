DC_FILE="srcs/docker-compose.yml"

build :
	docker compose -f ${DC_FILE} build
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress
up:
	docker compose -f ${DC_FILE} up
start:
	docker compose -f ${DC_FILE} start
restart:
	docker compose -f ${DC_FILE} restart
stop:
	docker compose -f ${DC_FILE} stop 
ls:
	docker image ls
psa:
	docker ps -a
rm:
	docker compose -f ${DC_FILE} rm
kill:
	docker compose -f ${DC_FILE} kill
rmv:
	sudo rm -rf ~/data

.PHONY: build up start restart stop psa ls rm rmv kill
