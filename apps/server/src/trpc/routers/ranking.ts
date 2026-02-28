import { desc } from "drizzle-orm";
import { players } from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const rankingRouter = router({
  byRails: protectedProcedure.query(async ({ ctx }) => {
    return ctx.db
      .select({
        id: players.id,
        name: players.name,
        rails: players.rails,
        exp: players.exp,
      })
      .from(players)
      .orderBy(desc(players.rails))
      .limit(20);
  }),

  byExp: protectedProcedure.query(async ({ ctx }) => {
    return ctx.db
      .select({
        id: players.id,
        name: players.name,
        rails: players.rails,
        exp: players.exp,
      })
      .from(players)
      .orderBy(desc(players.exp))
      .limit(20);
  }),
});
