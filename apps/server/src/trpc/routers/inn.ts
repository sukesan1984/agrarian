import { z } from "zod";
import { eq } from "drizzle-orm";
import { players, inns } from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const innRouter = router({
  get: protectedProcedure
    .input(z.object({ innId: z.number() }))
    .query(async ({ ctx, input }) => {
      const [inn] = await ctx.db
        .select()
        .from(inns)
        .where(eq(inns.id, input.innId))
        .limit(1);
      return inn ?? null;
    }),

  sleep: protectedProcedure
    .input(z.object({ innId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [inn] = await ctx.db
        .select()
        .from(inns)
        .where(eq(inns.id, input.innId))
        .limit(1);
      if (!inn) throw new Error("Inn not found");

      if (player.rails < inn.rails) throw new Error("Not enough rails");

      await ctx.db
        .update(players)
        .set({
          hp: player.hpMax,
          rails: player.rails - inn.rails,
        })
        .where(eq(players.id, player.id));

      return { success: true, healed: player.hpMax - player.hp };
    }),
});
