import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
  uniqueIndex,
  index,
} from "drizzle-orm/pg-core";
import { players } from "./players";

export const quests = pgTable("quests", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  rewardGiftId: integer("reward_gift_id"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const questConditions = pgTable("quest_conditions", {
  id: serial("id").primaryKey(),
  questId: integer("quest_id")
    .notNull()
    .references(() => quests.id),
  target: integer("target").notNull(),
  conditionType: integer("condition_type").notNull(),
  conditionId: integer("condition_id").notNull(),
  conditionValue: integer("condition_value").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const userQuests = pgTable(
  "user_quests",
  {
    id: serial("id").primaryKey(),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    questId: integer("quest_id")
      .notNull()
      .references(() => quests.id),
    status: integer("status").notNull(),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    uniqueIndex("user_quests_player_quest_idx").on(
      table.playerId,
      table.questId
    ),
  ]
);

export const userProgresses = pgTable(
  "user_progresses",
  {
    id: serial("id").primaryKey(),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    progressType: integer("progress_type").notNull(),
    progressId: integer("progress_id").notNull(),
    count: integer("count").notNull(),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    uniqueIndex("user_progresses_composite_idx").on(
      table.playerId,
      table.progressType,
      table.progressId
    ),
  ]
);
