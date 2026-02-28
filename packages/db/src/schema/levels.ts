import {
  pgTable,
  serial,
  integer,
  timestamp,
  index,
} from "drizzle-orm/pg-core";

export const levels = pgTable(
  "levels",
  {
    id: serial("id").primaryKey(),
    level: integer("level").notNull(),
    expMin: integer("exp_min").notNull(),
    expMax: integer("exp_max").notNull(),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [index("levels_level_idx").on(table.level)]
);
