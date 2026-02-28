import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
  index,
  uniqueIndex,
} from "drizzle-orm/pg-core";
import { players } from "./players";
import { areaNodes } from "./areas";

export const items = pgTable("items", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  itemType: integer("item_type").notNull(),
  itemTypeId: integer("item_type_id"),
  purchasePrice: integer("purchase_price"),
  sellPrice: integer("sell_price"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const userItems = pgTable(
  "user_items",
  {
    id: serial("id").primaryKey(),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    itemId: integer("item_id")
      .notNull()
      .references(() => items.id),
    count: integer("count").notNull().default(0),
    equipped: integer("equipped").notNull().default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    index("user_items_player_item_idx").on(table.playerId, table.itemId),
  ]
);

export const consumptions = pgTable(
  "consumptions",
  {
    id: serial("id").primaryKey(),
    itemId: integer("item_id")
      .notNull()
      .references(() => items.id),
    consumptionType: integer("consumption_type").notNull(),
    typeValue: integer("type_value").notNull(),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [uniqueIndex("consumptions_item_id_idx").on(table.itemId)]
);

export const thrownItems = pgTable(
  "thrown_items",
  {
    id: serial("id").primaryKey(),
    areaNodeId: integer("area_node_id")
      .notNull()
      .references(() => areaNodes.id),
    itemId: integer("item_id")
      .notNull()
      .references(() => items.id),
    count: integer("count").notNull(),
    thrownAt: timestamp("thrown_at").notNull().defaultNow(),
    lockVersion: integer("lock_version").notNull().default(0),
    userItemId: integer("user_item_id").notNull().default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    uniqueIndex("thrown_items_composite_idx").on(
      table.areaNodeId,
      table.itemId,
      table.userItemId
    ),
  ]
);

export const itemLotteries = pgTable("item_lotteries", {
  id: serial("id").primaryKey(),
  groupId: integer("group_id").notNull(),
  itemId: integer("item_id")
    .notNull()
    .references(() => items.id),
  count: integer("count").notNull(),
  weight: integer("weight").notNull(),
  compositeGroupId: integer("composite_group_id").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const itemAbilities = pgTable("item_abilities", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const itemAbilityLists = pgTable("item_ability_lists", {
  id: serial("id").primaryKey(),
  itemId: integer("item_id")
    .notNull()
    .references(() => items.id),
  itemAbilityId: integer("item_ability_id")
    .notNull()
    .references(() => itemAbilities.id),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const gifts = pgTable("gifts", {
  id: serial("id").primaryKey(),
  itemId: integer("item_id")
    .notNull()
    .references(() => items.id),
  count: integer("count").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const harvests = pgTable("harvests", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  itemAbilityId: integer("item_ability_id").references(
    () => itemAbilities.id
  ),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});
