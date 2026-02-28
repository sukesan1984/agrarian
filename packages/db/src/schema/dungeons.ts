import {
  pgTable,
  serial,
  integer,
  text,
  boolean,
  timestamp,
  uniqueIndex,
} from "drizzle-orm/pg-core";
import { players } from "./players";

export const dungeons = pgTable("dungeons", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  maxFloor: integer("max_floor").notNull().default(0),
  minSearch: integer("min_search").notNull().default(0),
  maxSearch: integer("max_search").notNull().default(0),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const userDungeons = pgTable(
  "user_dungeons",
  {
    id: serial("id").primaryKey(),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    dungeonId: integer("dungeon_id")
      .notNull()
      .references(() => dungeons.id),
    currentFloor: integer("current_floor").notNull().default(0),
    searchCount: integer("search_count").notNull().default(0),
    foundFootstep: boolean("found_footstep").notNull().default(false),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [uniqueIndex("user_dungeons_player_id_idx").on(table.playerId)]
);
