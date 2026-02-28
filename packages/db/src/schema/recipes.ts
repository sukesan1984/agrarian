import { pgTable, serial, integer, timestamp } from "drizzle-orm/pg-core";
import { items } from "./items";

export const recipes = pgTable("recipes", {
  id: serial("id").primaryKey(),
  requiredItemId1: integer("required_item_id1").references(() => items.id),
  requiredItemCount1: integer("required_item_count1"),
  requiredItemId2: integer("required_item_id2").references(() => items.id),
  requiredItemCount2: integer("required_item_count2"),
  requiredItemId3: integer("required_item_id3").references(() => items.id),
  requiredItemCount3: integer("required_item_count3"),
  requiredItemId4: integer("required_item_id4").references(() => items.id),
  requiredItemCount4: integer("required_item_count4"),
  requiredItemId5: integer("required_item_id5").references(() => items.id),
  requiredItemCount5: integer("required_item_count5"),
  productItemId: integer("product_item_id")
    .notNull()
    .references(() => items.id),
  productItemCount: integer("product_item_count").notNull(),
  skillId: integer("skill_id"),
  difficulty: integer("difficulty"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});
