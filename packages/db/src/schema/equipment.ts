import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
  index,
  uniqueIndex,
} from "drizzle-orm/pg-core";
import { items, userItems } from "./items";
import { players } from "./players";

export const equipment = pgTable("equipment", {
  id: serial("id").primaryKey(),
  itemId: integer("item_id")
    .notNull()
    .references(() => items.id),
  bodyRegion: integer("body_region").notNull(),
  attack: integer("attack"),
  damageMin: integer("damage_min").notNull().default(0),
  damageMax: integer("damage_max"),
  defense: integer("defense"),
  criticalHitChance: integer("critical_hit_chance").notNull().default(0),
  criticalHitDamage: integer("critical_hit_damage").notNull().default(0),
  dodgeChance: integer("dodge_chance").notNull().default(0),
  damageReduction: integer("damage_reduction").notNull().default(0),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const equipmentAffixes = pgTable("equipment_affixes", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  equipmentType: integer("equipment_type").notNull(),
  affixGroup: integer("affix_group").notNull(),
  affixType: integer("affix_type").notNull(),
  rarity: integer("rarity").notNull(),
  damagePercMin: integer("damage_perc_min"),
  damagePercMax: integer("damage_perc_max"),
  attackRatingPercMin: integer("attack_rating_perc_min"),
  attackRatingPercMax: integer("attack_rating_perc_max"),
  defensePercMin: integer("defense_perc_min"),
  defensePercMax: integer("defense_perc_max"),
  hpMin: integer("hp_min"),
  hpMax: integer("hp_max"),
  hpStealPercMin: integer("hp_steal_perc_min"),
  hpStealPercMax: integer("hp_steal_perc_max"),
  strMin: integer("str_min").notNull().default(0),
  strMax: integer("str_max").notNull().default(0),
  dexMin: integer("dex_min").notNull().default(0),
  dexMax: integer("dex_max").notNull().default(0),
  vitMin: integer("vit_min").notNull().default(0),
  vitMax: integer("vit_max").notNull().default(0),
  eneMin: integer("ene_min").notNull().default(0),
  eneMax: integer("ene_max").notNull().default(0),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const userEquipments = pgTable(
  "user_equipments",
  {
    id: serial("id").primaryKey(),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    rightHand: integer("right_hand"),
    leftHand: integer("left_hand"),
    bothHand: integer("both_hand"),
    body: integer("body"),
    head: integer("head"),
    leg: integer("leg"),
    neck: integer("neck"),
    belt: integer("belt"),
    amulet: integer("amulet"),
    ringA: integer("ring_a"),
    ringB: integer("ring_b"),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    uniqueIndex("user_equipments_player_id_idx").on(table.playerId),
  ]
);

export const userEquipmentAffixes = pgTable(
  "user_equipment_affixes",
  {
    id: serial("id").primaryKey(),
    userItemId: integer("user_item_id")
      .notNull()
      .references(() => userItems.id, { onDelete: "cascade" }),
    equipmentAffixId: integer("equipment_affix_id")
      .notNull()
      .references(() => equipmentAffixes.id),
    damagePerc: integer("damage_perc").notNull().default(0),
    attackRatingPerc: integer("attack_rating_perc").notNull().default(0),
    defensePerc: integer("defense_perc").notNull().default(0),
    hp: integer("hp").notNull().default(0),
    hpStealPerc: integer("hp_steal_perc").notNull().default(0),
    str: integer("str").notNull().default(0),
    dex: integer("dex").notNull().default(0),
    vit: integer("vit").notNull().default(0),
    ene: integer("ene").notNull().default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    index("user_equipment_affixes_user_item_id_idx").on(table.userItemId),
  ]
);
