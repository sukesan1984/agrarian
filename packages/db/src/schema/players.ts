import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
  uniqueIndex,
} from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";
import { users } from "./users";

export const players = pgTable(
  "players",
  {
    id: serial("id").primaryKey(),
    userId: text("user_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    name: text("name").notNull(),
    hp: integer("hp").notNull().default(50),
    hpMax: integer("hp_max").notNull().default(50),
    rails: integer("rails").notNull().default(300),
    str: integer("str").notNull().default(5),
    dex: integer("dex").notNull().default(2),
    vit: integer("vit").notNull().default(8),
    ene: integer("ene").notNull().default(3),
    remainingPoints: integer("remaining_points").notNull().default(0),
    exp: integer("exp").notNull().default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [uniqueIndex("players_user_id_idx").on(table.userId)]
);

export const playersRelations = relations(players, ({ one }) => ({
  user: one(users, { fields: [players.userId], references: [users.id] }),
}));

export const userAreas = pgTable("user_areas", {
  playerId: integer("player_id")
    .primaryKey()
    .references(() => players.id, { onDelete: "cascade" }),
  areaNodeId: integer("area_node_id").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const userBanks = pgTable(
  "user_banks",
  {
    id: serial("id").primaryKey(),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    rails: integer("rails").notNull().default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [uniqueIndex("user_banks_player_id_idx").on(table.playerId)]
);
