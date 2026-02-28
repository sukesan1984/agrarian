import {
  pgTable,
  serial,
  integer,
  text,
  timestamp,
  index,
} from "drizzle-orm/pg-core";
import { players } from "./players";

export const soldiers = pgTable("soldiers", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  strMin: integer("str_min").notNull(),
  strMax: integer("str_max").notNull(),
  dexMin: integer("dex_min").notNull(),
  dexMax: integer("dex_max").notNull(),
  vitMin: integer("vit_min").notNull(),
  vitMax: integer("vit_max").notNull(),
  eneMin: integer("ene_min").notNull().default(0),
  eneMax: integer("ene_max").notNull().default(0),
  levelMax: integer("level_max"),
  criticalHitChanceMin: integer("critical_hit_chance_min")
    .notNull()
    .default(0),
  criticalHitChanceMax: integer("critical_hit_chance_max")
    .notNull()
    .default(0),
  criticalHitDamageMin: integer("critical_hit_damage_min")
    .notNull()
    .default(0),
  criticalHitDamageMax: integer("critical_hit_damage_max")
    .notNull()
    .default(0),
  dodgeChanceMin: integer("dodge_chance_min").notNull().default(0),
  dodgeChanceMax: integer("dodge_chance_max").notNull().default(0),
  damageReductionMin: integer("damage_reduction_min").notNull().default(0),
  damageReductionMax: integer("damage_reduction_max").notNull().default(0),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const userSoldiers = pgTable(
  "user_soldiers",
  {
    id: serial("id").primaryKey(),
    playerId: integer("player_id")
      .notNull()
      .references(() => players.id, { onDelete: "cascade" }),
    soldierId: integer("soldier_id")
      .notNull()
      .references(() => soldiers.id),
    currentHp: integer("current_hp").notNull(),
    exp: integer("exp").notNull().default(0),
    isInParty: integer("is_in_party").notNull().default(0),
    rightHand: integer("right_hand").default(0),
    leftHand: integer("left_hand").default(0),
    bothHand: integer("both_hand").default(0),
    body: integer("body").default(0),
    head: integer("head").default(0),
    leg: integer("leg").default(0),
    neck: integer("neck").default(0),
    belt: integer("belt").default(0),
    amulet: integer("amulet").default(0),
    ringA: integer("ring_a").default(0),
    ringB: integer("ring_b").default(0),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [
    index("user_soldiers_player_id_idx").on(table.playerId),
    index("user_soldiers_player_party_idx").on(
      table.playerId,
      table.isInParty
    ),
  ]
);
