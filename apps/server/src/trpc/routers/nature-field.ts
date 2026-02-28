import { z } from "zod";
import { eq, and } from "drizzle-orm";
import {
  players,
  natureFields,
  resources,
  resourceKeepers,
  items,
  userItems,
} from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const natureFieldRouter = router({
  get: protectedProcedure
    .input(z.object({ fieldId: z.number() }))
    .query(async ({ ctx, input }) => {
      const [field] = await ctx.db
        .select()
        .from(natureFields)
        .where(eq(natureFields.id, input.fieldId))
        .limit(1);
      if (!field || !field.resourceId) return null;

      const [resource] = await ctx.db
        .select()
        .from(resources)
        .where(eq(resources.id, field.resourceId))
        .limit(1);

      return { field, resource: resource ?? null };
    }),

  harvest: protectedProcedure
    .input(z.object({ fieldId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [field] = await ctx.db
        .select()
        .from(natureFields)
        .where(eq(natureFields.id, input.fieldId))
        .limit(1);
      if (!field || !field.resourceId) throw new Error("Field not found");

      const [resource] = await ctx.db
        .select()
        .from(resources)
        .where(eq(resources.id, field.resourceId))
        .limit(1);
      if (!resource || !resource.itemId) throw new Error("Resource not found");

      const [keeper] = await ctx.db
        .select()
        .from(resourceKeepers)
        .where(eq(resourceKeepers.resourceId, resource.id))
        .limit(1);

      if (keeper && keeper.currentCount <= 0) {
        throw new Error("Resource depleted");
      }

      if (keeper) {
        await ctx.db
          .update(resourceKeepers)
          .set({ currentCount: keeper.currentCount - 1 })
          .where(eq(resourceKeepers.id, keeper.id));
      }

      const [existing] = await ctx.db
        .select()
        .from(userItems)
        .where(
          and(
            eq(userItems.playerId, player.id),
            eq(userItems.itemId, resource.itemId)
          )
        )
        .limit(1);

      if (existing) {
        await ctx.db
          .update(userItems)
          .set({ count: existing.count + 1 })
          .where(eq(userItems.id, existing.id));
      } else {
        await ctx.db.insert(userItems).values({
          playerId: player.id,
          itemId: resource.itemId,
          count: 1,
        });
      }

      return { success: true };
    }),
});
