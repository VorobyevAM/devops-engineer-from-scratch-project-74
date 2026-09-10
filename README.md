# Упаковка в Docker Compose

[![hexlet-check](https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74/actions)
[![Push](https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74/actions/workflows/push.yml/badge.svg)](https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74/actions/workflows/push.yml)

Автоматизация развертывания и обновления локального окружения с помощью Docker Compose, Github Actions (CI), Makefile

Учебный проект Хекслета: https://ru.hexlet.io/programs/devops-engineer-from-scratch
Как это должно работать: https://asciinema.org/a/zVrFYtslVReMsTyqEEetdWUY5

## Стек

- Node.js 26
- Fastify
- Docker и Docker Compose

## Установка

<!-- Опишите установку: клонирование, зависимости, переменные окружения -->

```bash
git clone https://github.com/VorobyevAM/devops-engineer-from-scratch-project-74.git
cd devops-engineer-from-scratch-project-74
make setup
```

## Использование

Запустите приложение:

```bash
make dev
```

После запуска блог доступен по адресу <http://localhost:8080>.

Запустите тесты в изолированной основной конфигурации Compose:

```bash
make test
```

Основной файл `docker-compose.yml` запускает тесты, а
`docker-compose.override.yml`, автоматически подключаемый при локальном запуске,
переопределяет команду на dev-сервер и публикует порт 8080.

Соберите production-образ и отправьте его в Docker Hub:

```bash
docker login
make build
make push
```

Production-образ публикуется как
`vorobyev93/devops-engineer-from-scratch-project-74:latest`.

Проверить собранный образ без Compose:

```bash
docker run --rm -p 8080:8080 -e NODE_ENV=development \
  vorobyev93/devops-engineer-from-scratch-project-74:latest make dev
```

Остановить и удалить контейнеры можно командой:

```bash
make down
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
