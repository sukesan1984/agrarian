import { pgTable, serial, integer, text, timestamp } from "drizzle-orm/pg-core";

export const roads = pgTable("roads", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  roadLength: integer("road_length"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});
