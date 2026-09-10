# Сборка отделена от финального образа: vite, tailwind, vitest и drizzle-kit
# нужны, чтобы собрать ассеты, а приложению в рантайме нет.
FROM node:26 AS builder

WORKDIR /app

# Зависимости ставятся до копирования кода, чтобы слой с ними переиспользовался
# и не пересобирался на каждую правку исходников.
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# Дерево обрезается здесь же, а не в финальном образе: тот тогда копирует
# готовый прод-набор и не ходит в реестр второй раз.
RUN npm prune --omit=dev

FROM node:26

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY package.json ./
COPY server ./server
COPY db ./db

# Приложение запускается нодой напрямую, без npm и Makefile: в финальном
# образе живёт одна команда, а пакетный менеджер в рантайме не нужен.
#
# Порт не задаётся: fastify-cli по умолчанию слушает 3000, и на этот порт
# рассчитан урок docker_basics_course/600-network, где контейнер запускают
# как `docker run -p 8080:3000`.
#
# Адрес обязателен: на 127.0.0.1 сервер внутри контейнера снаружи недоступен,
# ровно об этом урок и рассказывает.
#
# Флаг -o обязателен тоже: без него fastify-cli не читает экспорт `options` из
# плагина и регистрирует его дважды, падая с «Route with name root already
# registered».
CMD ["node", "node_modules/fastify-cli/cli.js", "start", "-a", "0.0.0.0", "-l", "info", "-P", "-o", "server/plugin.js"]
