#!make

build:
	docker-compose build

start:
	docker-compose up

detach:
	docker-compose up -d

stop:
	docker-compose down