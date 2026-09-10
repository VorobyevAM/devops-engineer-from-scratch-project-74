LOCAL_UID := $(shell id -u)
LOCAL_GID := $(shell id -g)
COMPOSE := LOCAL_UID=$(LOCAL_UID) LOCAL_GID=$(LOCAL_GID) docker compose

.PHONY: setup build ci test push dev down

.env: .env.example
	cp .env.example .env

setup: .env
	$(COMPOSE) build
	$(COMPOSE) run --rm app make setup

build:
	$(COMPOSE) -f docker-compose.yml build app

ci:
	$(COMPOSE) -f docker-compose.yml up --build --abort-on-container-exit --exit-code-from app

test: ci

push:
	$(COMPOSE) -f docker-compose.yml push app

dev:
	$(COMPOSE) up

down:
	$(COMPOSE) down
