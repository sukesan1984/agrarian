import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
  index,
} from "drizzle-orm/pg-core";
import { items } from "./items";

export const shops = pgTable("shops", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const shopProducts = pgTable(
  "shop_products",
  {
    id: serial("id").primaryKey(),
    shopId: integer("shop_id")
      .notNull()
      .references(() => shops.id),
    itemId: integer("item_id")
      .notNull()
      .references(() => items.id),
    count: integer("count").notNull(),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [index("shop_products_shop_id_idx").on(table.shopId)]
);

export const showcases = pgTable("showcases", {
  id: serial("id").primaryKey(),
  shopId: integer("shop_id")
    .notNull()
    .references(() => shops.id),
  resourceId: integer("resource_id").notNull(),
  cost: integer("cost").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});
