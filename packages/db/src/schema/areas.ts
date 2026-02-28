import {
  pgTable,
  serial,
  integer,
  timestamp,
  index,
} from "drizzle-orm/pg-core";

export const areas = pgTable("areas", {
  id: serial("id").primaryKey(),
  areaType: integer("area_type").notNull(),
  typeId: integer("type_id").notNull(),
  enemyRate: integer("enemy_rate"),
  enemyNum: integer("enemy_num"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const areaNodes = pgTable(
  "area_nodes",
  {
    id: serial("id").primaryKey(),
    areaId: integer("area_id")
      .notNull()
      .references(() => areas.id),
    nodePoint: integer("node_point").notNull(),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [index("area_nodes_area_id_idx").on(table.areaId)]
);

export const routes = pgTable(
  "routes",
  {
    id: serial("id").primaryKey(),
    areaNodeId: integer("area_node_id")
      .notNull()
      .references(() => areaNodes.id),
    connectedAreaNodeId: integer("connected_area_node_id")
      .notNull()
      .references(() => areaNodes.id),
    createdAt: timestamp("created_at").notNull().defaultNow(),
    updatedAt: timestamp("updated_at").notNull().defaultNow(),
  },
  (table) => [index("routes_area_node_id_idx").on(table.areaNodeId)]
);
