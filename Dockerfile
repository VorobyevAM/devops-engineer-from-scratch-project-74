FROM node:26

ARG PNPM_VERSION=11.24.0
ENV XDG_CONFIG_HOME=/etc

# The current application uses pnpm, which is no longer bundled with Node.js.
RUN npm install --global "pnpm@${PNPM_VERSION}"

RUN mkdir -p /etc/pnpm
COPY docker/pnpm-config.yaml /etc/pnpm/config.yaml

WORKDIR /app
