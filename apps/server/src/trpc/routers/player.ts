import { z } from "zod";
import { eq } from "drizzle-orm";
import { players, userAreas, userBanks, userEquipments } from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const playerRouter = router({
  me: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    return player ?? null;
  }),

  create: protectedProcedure
    .input(z.object({ name: z.string().min(1).max(20) }))
    .mutation(async ({ ctx, input }) => {
      const existing = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);

      if (existing.length > 0) {
        throw new Error("Player already exists");
      }

      const [player] = await ctx.db
        .insert(players)
        .values({ userId: ctx.user.id, name: input.name })
        .returning();

      await ctx.db
        .insert(userAreas)
        .values({ playerId: player.id, areaNodeId: 1 });
      await ctx.db
        .insert(userBanks)
        .values({ playerId: player.id });
      await ctx.db
        .insert(userEquipments)
        .values({ playerId: player.id });

      return player;
    }),

  get: protectedProcedure
    .input(z.object({ id: z.number() }))
    .query(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.id, input.id))
        .limit(1);
      return player ?? null;
    }),

  list: protectedProcedure.query(async ({ ctx }) => {
    return ctx.db.select().from(players);
  }),

  increaseStats: protectedProcedure
    .input(
      z.object({
        stat: z.enum(["str", "dex", "vit", "ene"]),
        amount: z.number().min(1),
      })
    )
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);

      if (!player || player.remainingPoints < input.amount) {
        throw new Error("Not enough points");
      }

      const updateData: Record<string, number> = {
        [input.stat]: player[input.stat] + input.amount,
        remainingPoints: player.remainingPoints - input.amount,
      };

      if (input.stat === "vit") {
        const hpIncrease = input.amount * 4;
        updateData.hpMax = player.hpMax + hpIncrease;
        updateData.hp = player.hp + hpIncrease;
      }

      const [updated] = await ctx.db
        .update(players)
        .set(updateData)
        .where(eq(players.id, player.id))
        .returning();

      return updated;
    }),

  rankingByRails: protectedProcedure.query(async ({ ctx }) => {
    return ctx.db
      .select()
      .from(players)
      .orderBy(players.rails)
      .limit(10);
  }),
});
