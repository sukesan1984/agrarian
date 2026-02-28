import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
  index,
} from "drizzle-orm/pg-core";
import { players } from "./players";

export const towns = pgTable("towns", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const establishments = pgTable("establishments", {
  id: serial("id").primaryKey(),
  townId: integer("town_id")
    .notNull()
    .references(() => towns.id),
  establishmentType: integer("establishment_type").notNull(),
  establishmentId: integer("establishment_id").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const townBulletinBoards = pgTable(
  "town_bulletin_boards",
  {
    id: serial("id").primaryKey(),
    townId: integer("town_id")
      .notNull()
      .references(() => towns.id),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id),
    contents: text("contents").notNull(),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [index("town_bulletin_boards_town_id_idx").on(table.townId)]
);
