import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
  index,
  uniqueIndex,
} from "drizzle-orm/pg-core";
import { areas } from "./areas";
import { players } from "./players";

export const enemies = pgTable("enemies", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  str: integer("str").notNull(),
  defense: integer("defense").notNull(),
  hp: integer("hp").notNull(),
  rails: integer("rails"),
  exp: integer("exp"),
  level: integer("level").notNull().default(0),
  dex: integer("dex"),
  damageMin: integer("damage_min").notNull().default(0),
  damageMax: integer("damage_max").notNull().default(0),
  itemLotteryGroupId: integer("item_lottery_group_id").notNull().default(0),
  dropItemRate: integer("drop_item_rate").notNull().default(0),
  criticalHitChance: integer("critical_hit_chance").notNull().default(0),
  criticalHitDamage: integer("critical_hit_damage").notNull().default(0),
  dodgeChance: integer("dodge_chance").notNull().default(0),
  damageReduction: integer("damage_reduction").notNull().default(0),
  itemRarity: integer("item_rarity"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const enemyMaps = pgTable(
  "enemy_maps",
  {
    id: serial("id").primaryKey(),
    areaId: integer("area_id")
      .notNull()
      .references(() => areas.id),
    enemyId: integer("enemy_id")
      .notNull()
      .references(() => enemies.id),
    weight: integer("weight").notNull(),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [index("enemy_maps_area_id_idx").on(table.areaId)]
);

export const enemyGroups = pgTable(
  "enemy_groups",
  {
    id: serial("id").primaryKey(),
    areaNodeId: integer("area_node_id").notNull(),
    status: integer("status").notNull().default(0),
    playerNum: integer("player_num").notNull().default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    index("enemy_groups_composite_idx").on(
      table.areaNodeId,
      table.status,
      table.playerNum
    ),
  ]
);

export const enemyInstances = pgTable(
  "enemy_instances",
  {
    id: serial("id").primaryKey(),
    enemyGroupId: integer("enemy_group_id")
      .notNull()
      .references(() => enemyGroups.id, { onDelete: "cascade" }),
    enemyId: integer("enemy_id")
      .notNull()
      .references(() => enemies.id),
    currentHp: integer("current_hp").notNull().default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    index("enemy_instances_enemy_group_id_idx").on(table.enemyGroupId),
  ]
);

export const userEncounterEnemies = pgTable(
  "user_encounter_enemies",
  {
    id: serial("id").primaryKey(),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    enemyId: integer("enemy_id")
      .notNull()
      .references(() => enemies.id),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    index("user_encounter_enemies_player_id_idx").on(table.playerId),
  ]
);

export const userEncounterEnemyGroups = pgTable(
  "user_encounter_enemy_groups",
  {
    id: serial("id").primaryKey(),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    enemyGroupId: integer("enemy_group_id")
      .notNull()
      .references(() => enemyGroups.id, { onDelete: "cascade" }),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    uniqueIndex("user_encounter_enemy_groups_player_id_idx").on(
      table.playerId
    ),
    index("user_encounter_enemy_groups_enemy_group_id_idx").on(
      table.enemyGroupId
    ),
  ]
);

export const userEnemyHistories = pgTable(
  "user_enemy_histories",
  {
    id: serial("id").primaryKey(),
    enemyInstanceId: integer("enemy_instance_id")
      .notNull()
      .references(() => enemyInstances.id, { onDelete: "cascade" }),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    damage: integer("damage").notNull().default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    uniqueIndex("user_enemy_histories_composite_idx").on(
      table.enemyInstanceId,
      table.playerId
    ),
    index("user_enemy_histories_enemy_instance_id_idx").on(
      table.enemyInstanceId
    ),
  ]
);
