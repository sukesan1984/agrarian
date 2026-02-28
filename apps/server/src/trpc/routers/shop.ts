import { z } from "zod";
import { eq, and } from "drizzle-orm";
import {
  players,
  shops,
  showcases,
  resources,
  resourceKeepers,
  items,
  userItems,
} from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const shopRouter = router({
  get: protectedProcedure
    .input(z.object({ shopId: z.number() }))
    .query(async ({ ctx, input }) => {
      const [shop] = await ctx.db
        .select()
        .from(shops)
        .where(eq(shops.id, input.shopId))
        .limit(1);
      if (!shop) return null;

      const shopShowcases = await ctx.db
        .select({ showcase: showcases, resource: resources })
        .from(showcases)
        .innerJoin(resources, eq(showcases.resourceId, resources.id))
        .where(eq(showcases.shopId, shop.id));

      const showcaseDetails = await Promise.all(
        shopShowcases.map(async (s) => {
          const [item] = s.resource.itemId
            ? await ctx.db
                .select()
                .from(items)
                .where(eq(items.id, s.resource.itemId))
                .limit(1)
            : [null];
          return { ...s, item };
        })
      );

      return { shop, showcases: showcaseDetails };
    }),

  buy: protectedProcedure
    .input(z.object({ showcaseId: z.number(), count: z.number().min(1) }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [showcase] = await ctx.db
        .select()
        .from(showcases)
        .where(eq(showcases.id, input.showcaseId))
        .limit(1);
      if (!showcase) throw new Error("Showcase not found");

      const totalCost = showcase.cost * input.count;
      if (player.rails < totalCost) throw new Error("Not enough rails");

      const [resource] = await ctx.db
        .select()
        .from(resources)
        .where(eq(resources.id, showcase.resourceId))
        .limit(1);
      if (!resource || !resource.itemId) throw new Error("Invalid resource");

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
          .set({ count: existing.count + input.count })
          .where(eq(userItems.id, existing.id));
      } else {
        await ctx.db.insert(userItems).values({
          playerId: player.id,
          itemId: resource.itemId,
          count: input.count,
        });
      }

      await ctx.db
        .update(players)
        .set({ rails: player.rails - totalCost })
        .where(eq(players.id, player.id));

      return { success: true, spent: totalCost };
    }),
});
