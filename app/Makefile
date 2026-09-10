setup: install build

install:
	npm install

build:
	npm run build

prepare-env:
	cp -n .env.example .env

start:
	NODE_ENV=production npm run start

dev:
	npx concurrently "make start-frontend" "make start-backend"

start-backend:
	npm run start -- --watch --verbose-watch --ignore-watch='node_modules .git dist database'

start-frontend:
	npx vite build --watch

lint:
	npm --silent run lint
	npm --silent run format:check

lint-fix:
	npm --silent run lint:fix

test:
	NODE_ENV=test npm --silent test
