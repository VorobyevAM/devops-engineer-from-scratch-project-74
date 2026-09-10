import { defineConfig } from "drizzle-kit";

// Миграции генерируются по схеме, подключение для этого не нужно:
//
//   npm run db:generate
export default defineConfig({
  dialect: "postgresql",
  schema: "./db/schema/index.js",
  out: "./db/migrations",
});
