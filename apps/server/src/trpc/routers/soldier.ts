import { z } from "zod";
import { eq, and } from "drizzle-orm";
import { players, soldiers, userSoldiers } from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const soldierRouter = router({
  list: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) return [];

    return ctx.db
      .select({ userSoldier: userSoldiers, soldier: soldiers })
      .from(userSoldiers)
      .innerJoin(soldiers, eq(userSoldiers.soldierId, soldiers.id))
      .where(eq(userSoldiers.playerId, player.id));
  }),

  addToParty: protectedProcedure
    .input(z.object({ userSoldierId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      await ctx.db
        .update(userSoldiers)
        .set({ isInParty: 1 })
        .where(
          and(
            eq(userSoldiers.id, input.userSoldierId),
            eq(userSoldiers.playerId, player.id)
          )
        );

      return { success: true };
    }),

  removeFromParty: protectedProcedure
    .input(z.object({ userSoldierId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      await ctx.db
        .update(userSoldiers)
        .set({ isInParty: 0 })
        .where(
          and(
            eq(userSoldiers.id, input.userSoldierId),
            eq(userSoldiers.playerId, player.id)
          )
        );

      return { success: true };
    }),
});
