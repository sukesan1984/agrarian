import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
  uniqueIndex,
} from "drizzle-orm/pg-core";
import { items } from "./items";

export const resources = pgTable("resources", {
  id: serial("id").primaryKey(),
  name: text("name"),
  itemId: integer("item_id").references(() => items.id),
  recoverCount: integer("recover_count").notNull(),
  recoverInterval: integer("recover_interval").notNull(),
  maxCount: integer("max_count").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const resourceKeepers = pgTable(
  "resource_keepers",
  {
    id: serial("id").primaryKey(),
    targetId: integer("target_id").notNull(),
    resourceId: integer("resource_id")
      .notNull()
      .default(1)
      .references(() => resources.id),
    currentCount: integer("current_count").notNull(),
    lastRecoveredAt: timestamp("last_recovered_at"),
    lockVersion: integer("lock_version").notNull().default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    uniqueIndex("resource_keepers_target_resource_idx").on(
      table.targetId,
      table.resourceId
    ),
  ]
);

export const resourceActions = pgTable("resource_actions", {
  id: serial("id").primaryKey(),
  actionType: integer("action_type").notNull(),
  actionId: integer("action_id").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const natureFields = pgTable("nature_fields", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  resourceActionId: integer("resource_action_id").references(
    () => resourceActions.id
  ),
  resourceId: integer("resource_id").references(() => resources.id),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});
