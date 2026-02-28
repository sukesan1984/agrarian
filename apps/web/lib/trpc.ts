import { createTRPCReact } from "@trpc/react-query";
import type { AppRouter } from "@agrarian/server/trpc/router";

export const trpc = createTRPCReact<AppRouter>();
