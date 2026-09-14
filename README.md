# Упаковка в Docker Compose

[![hexlet-check](https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74/actions)
[![Push](https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74/actions/workflows/push.yml/badge.svg)](https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74/actions/workflows/push.yml)

Учебное Fastify-приложение, упакованное с помощью Docker Compose. Проект
включает PostgreSQL, reverse proxy Caddy с локальным HTTPS и GitHub Actions,
который запускает тесты и публикует production-образ в Docker Hub.

[Учебный проект Хекслета](https://ru.hexlet.io/programs/devops-engineer-from-scratch)

## Требования

- Git
- GNU Make
- Docker Engine или Docker Desktop
- Docker Compose 1.27.0 или новее (рекомендуется Compose v2 — команда `docker compose`)

Node.js и PostgreSQL устанавливать на хост не нужно: зависимости и сервисы
запускаются в контейнерах. Для локального запуска должны быть свободны порты
80 и 443.

## Установка

```bash
git clone https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74.git
cd devops-engineer-from-scratch-project-74
make setup
```

При первом запуске `make setup` создаёт локальный `.env` из `.env.example`,
собирает образы и устанавливает зависимости приложения внутри Docker.
Контейнер приложения подключается к PostgreSQL по имени сервиса `db`.

Доступные переменные окружения:

| Переменная | Значение по умолчанию | Назначение |
|---|---|---|
| `DATABASE_HOST` | `db` | Имя сервиса PostgreSQL |
| `DATABASE_PORT` | `5432` | Порт PostgreSQL |
| `DATABASE_NAME` | `postgres` | Имя базы данных |
| `DATABASE_USERNAME` | `postgres` | Пользователь базы данных |
| `DATABASE_PASSWORD` | `password` | Пароль базы данных |

Значения можно переопределить в локальном файле `.env`. Этот файл исключён из
Git; пример конфигурации находится в `.env.example`.

## Использование

Основные команды:

| Команда | Назначение |
|---|---|
| `make setup` | Подготовить `.env`, образы и зависимости |
| `make dev` | Запустить приложение, PostgreSQL и Caddy |
| `make test` | Собрать production-образ и запустить тесты в Docker Compose |
| `make build` | Собрать production-образ |
| `make push` | Отправить production-образ в Docker Hub |
| `make down` | Остановить и удалить контейнеры проекта |

Запуск приложения:

```bash
make dev
```

После запуска Caddy перенаправляет <http://localhost> на
<https://localhost> и проксирует запросы к Fastify. Локальный TLS-сертификат
выпущен внутренним центром сертификации Caddy, поэтому браузер может показать
предупреждение о недоверенном сертификате.

Запуск тестов в изолированной основной конфигурации Compose:

```bash
make test
```

Основной файл `docker-compose.yml` собирает приложение через
`Dockerfile.production` и запускает тесты без публикации портов.
`docker-compose.override.yml` автоматически подключается при локальном запуске,
использует минимальный `Dockerfile`, монтирует исходники, запускает `make dev` и
добавляет Caddy с портами 80 и 443.

Соберите production-образ и отправьте его в Docker Hub:

```bash
docker login
make build
make push
```

Production-образ:
[vorobyev93/devops-engineer-from-scratch-project-74](https://hub.docker.com/r/vorobyev93/devops-engineer-from-scratch-project-74)
(`latest`). Каждый CI-запуск также публикует неизменяемый тег с полным SHA
коммита, поэтому при необходимости можно запустить или восстановить конкретную
версию образа.

Проверить собранный образ без Compose:

```bash
docker run --rm -p 8080:8080 -e NODE_ENV=development \
  vorobyev93/devops-engineer-from-scratch-project-74:latest make dev
```

`Makefile` передаёт Docker Compose идентификаторы текущего пользователя. Поэтому
файлы, созданные контейнером в каталоге `app/`, не принадлежат `root`.

---

<details>
<summary>Автоматические тесты Хекслета</summary>

Тесты запускаются на каждый коммит. За запуск отвечает файл `.github/workflows/hexlet-check.yml` — не удаляйте и не переименовывайте ни его, ни репозиторий.

</details>

## О Хекслете

[Хекслет](https://ru.hexlet.io/) — школа программирования: авторские программы обучения с практикой, поддержкой наставников и реальными проектами, которые остаются в резюме. Этот репозиторий — один из таких проектов.
