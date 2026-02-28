import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
} from "drizzle-orm/pg-core";

export const inns = pgTable("inns", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  rails: integer("rails").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});
