import { z } from "zod";
import { eq, and } from "drizzle-orm";
import { players, recipes, items, userItems } from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const recipeRouter = router({
  list: protectedProcedure.query(async ({ ctx }) => {
    const allRecipes = await ctx.db.select().from(recipes);

    const withItems = await Promise.all(
      allRecipes.map(async (r) => {
        const productItem = r.productItemId
          ? await ctx.db
              .select()
              .from(items)
              .where(eq(items.id, r.productItemId))
              .limit(1)
          : [];

        return {
          ...r,
          productItem: productItem[0] ?? null,
        };
      })
    );

    return withItems;
  }),

  make: protectedProcedure
    .input(z.object({ recipeId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [recipe] = await ctx.db
        .select()
        .from(recipes)
        .where(eq(recipes.id, input.recipeId))
        .limit(1);
      if (!recipe) throw new Error("Recipe not found");

      const requiredItems: { itemId: number; count: number }[] = [];
      for (let i = 1; i <= 5; i++) {
        const itemId = (recipe as Record<string, unknown>)[
          `requiredItemId${i}`
        ] as number | null;
        const count = (recipe as Record<string, unknown>)[
          `requiredItemCount${i}`
        ] as number | null;
        if (itemId && count) {
          requiredItems.push({ itemId, count });
        }
      }

      for (const req of requiredItems) {
        const [ui] = await ctx.db
          .select()
          .from(userItems)
          .where(
            and(
              eq(userItems.playerId, player.id),
              eq(userItems.itemId, req.itemId)
            )
          )
          .limit(1);
        if (!ui || ui.count < req.count) {
          throw new Error("Not enough materials");
        }
      }

      for (const req of requiredItems) {
        const [ui] = await ctx.db
          .select()
          .from(userItems)
          .where(
            and(
              eq(userItems.playerId, player.id),
              eq(userItems.itemId, req.itemId)
            )
          )
          .limit(1);
        const newCount = ui!.count - req.count;
        if (newCount <= 0) {
          await ctx.db.delete(userItems).where(eq(userItems.id, ui!.id));
        } else {
          await ctx.db
            .update(userItems)
            .set({ count: newCount })
            .where(eq(userItems.id, ui!.id));
        }
      }

      const [existing] = await ctx.db
        .select()
        .from(userItems)
        .where(
          and(
            eq(userItems.playerId, player.id),
            eq(userItems.itemId, recipe.productItemId)
          )
        )
        .limit(1);

      if (existing) {
        await ctx.db
          .update(userItems)
          .set({ count: existing.count + recipe.productItemCount })
          .where(eq(userItems.id, existing.id));
      } else {
        await ctx.db.insert(userItems).values({
          playerId: player.id,
          itemId: recipe.productItemId,
          count: recipe.productItemCount,
        });
      }

      return { success: true };
    }),
});
