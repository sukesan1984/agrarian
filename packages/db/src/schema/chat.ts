import { pgTable, serial, timestamp } from "drizzle-orm/pg-core";

export const chatRooms = pgTable("chat_rooms", {
  id: serial("id").primaryKey(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});
