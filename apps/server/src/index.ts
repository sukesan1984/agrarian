import "dotenv/config";
import { Hono } from "hono";
import { cors } from "hono/cors";
import { trpcServer } from "@hono/trpc-server";
import { serve } from "@hono/node-server";
import { appRouter } from "./trpc/router";
import { createContext } from "./trpc/context";
import { auth } from "./auth";

const app = new Hono();

app.use(
  "/*",
  cors({
    origin: (origin) => {
      if (!origin) return "http://localhost:3000";
      if (origin.startsWith("http://localhost:")) return origin;
      return null;
    },
    credentials: true,
    allowHeaders: ["Content-Type", "Authorization"],
    allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  })
);

app.on(["POST", "GET"], "/api/auth/**", (c) => {
  return auth.handler(c.req.raw);
});

app.use(
  "/trpc/*",
  trpcServer({
    router: appRouter,
    createContext,
  })
);

app.get("/health", (c) => c.json({ status: "ok" }));

const port = Number(process.env.PORT) || 3100;
console.log(`Server starting on http://localhost:${port}`);

serve({ fetch: app.fetch, port });
