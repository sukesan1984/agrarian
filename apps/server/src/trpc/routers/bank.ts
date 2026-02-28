import { z } from "zod";
import { eq } from "drizzle-orm";
import { players, userBanks } from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const bankRouter = router({
  status: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) return null;

    const [bank] = await ctx.db
      .select()
      .from(userBanks)
      .where(eq(userBanks.playerId, player.id))
      .limit(1);

    return bank ?? null;
  }),

  deposit: protectedProcedure
    .input(z.object({ amount: z.number().min(1) }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");
      if (player.rails < input.amount) throw new Error("Not enough rails");

      const [bank] = await ctx.db
        .select()
        .from(userBanks)
        .where(eq(userBanks.playerId, player.id))
        .limit(1);
      if (!bank) throw new Error("No bank account");

      await ctx.db
        .update(players)
        .set({ rails: player.rails - input.amount })
        .where(eq(players.id, player.id));

      await ctx.db
        .update(userBanks)
        .set({ rails: bank.rails + input.amount })
        .where(eq(userBanks.playerId, player.id));

      return { success: true };
    }),

  withdraw: protectedProcedure
    .input(z.object({ amount: z.number().min(1) }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [bank] = await ctx.db
        .select()
        .from(userBanks)
        .where(eq(userBanks.playerId, player.id))
        .limit(1);
      if (!bank) throw new Error("No bank account");
      if (bank.rails < input.amount) throw new Error("Not enough rails in bank");

      await ctx.db
        .update(players)
        .set({ rails: player.rails + input.amount })
        .where(eq(players.id, player.id));

      await ctx.db
        .update(userBanks)
        .set({ rails: bank.rails - input.amount })
        .where(eq(userBanks.playerId, player.id));

      return { success: true };
    }),
});
