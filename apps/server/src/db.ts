import { createDb } from "@agrarian/db";

export const db = createDb(process.env.DATABASE_URL!);
