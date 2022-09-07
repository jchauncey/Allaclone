
.PHONY: clean-db
clean-db:
	docker rm -f alladb

.PHONY: db
db:
	docker build -t alla-db -f Dockerfile.mariadb .

.PHONY: run-db
run-db: clean-db
	docker run -p 3306:3306 --name alladb -e MARIADB_ROOT_PASSWORD=root -d alla-db --port 3306
	sleep 120

.PHONY: clean
clean:
	docker rm -f allaclone

.PHONY: build
build:
	docker build -t allaclone .

.PHONY: run
run: clean
	docker run --name allaclone --link=alladb:alladb -p 80:80 -d allaclone

.PHONY: exec
exec:
	docker exec -it allaclone bash
