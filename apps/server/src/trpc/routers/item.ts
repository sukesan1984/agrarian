import { z } from "zod";
import { eq, and } from "drizzle-orm";
import {
  players,
  items,
  userItems,
  consumptions,
  thrownItems,
  userAreas,
} from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const itemRouter = router({
  inventory: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) return [];

    return ctx.db
      .select({ userItem: userItems, item: items })
      .from(userItems)
      .innerJoin(items, eq(userItems.itemId, items.id))
      .where(eq(userItems.playerId, player.id));
  }),

  use: protectedProcedure
    .input(z.object({ userItemId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [ui] = await ctx.db
        .select()
        .from(userItems)
        .where(
          and(
            eq(userItems.id, input.userItemId),
            eq(userItems.playerId, player.id)
          )
        )
        .limit(1);
      if (!ui || ui.count <= 0) throw new Error("Item not found");

      const [consumption] = await ctx.db
        .select()
        .from(consumptions)
        .where(eq(consumptions.itemId, ui.itemId))
        .limit(1);

      let effect = "";
      if (consumption) {
        if (consumption.consumptionType === 1) {
          const healed = Math.min(
            consumption.typeValue,
            player.hpMax - player.hp
          );
          await ctx.db
            .update(players)
            .set({ hp: player.hp + healed })
            .where(eq(players.id, player.id));
          effect = `HPが${healed}回復した！`;
        }
      }

      const newCount = ui.count - 1;
      if (newCount <= 0) {
        await ctx.db
          .delete(userItems)
          .where(eq(userItems.id, input.userItemId));
      } else {
        await ctx.db
          .update(userItems)
          .set({ count: newCount })
          .where(eq(userItems.id, input.userItemId));
      }

      return { success: true, effect };
    }),

  sell: protectedProcedure
    .input(z.object({ userItemId: z.number(), count: z.number().min(1) }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [ui] = await ctx.db
        .select({ userItem: userItems, item: items })
        .from(userItems)
        .innerJoin(items, eq(userItems.itemId, items.id))
        .where(
          and(
            eq(userItems.id, input.userItemId),
            eq(userItems.playerId, player.id)
          )
        )
        .limit(1);
      if (!ui || ui.userItem.count < input.count) throw new Error("Not enough items");

      const sellPrice = (ui.item.sellPrice ?? 0) * input.count;

      const newCount = ui.userItem.count - input.count;
      if (newCount <= 0) {
        await ctx.db.delete(userItems).where(eq(userItems.id, input.userItemId));
      } else {
        await ctx.db
          .update(userItems)
          .set({ count: newCount })
          .where(eq(userItems.id, input.userItemId));
      }

      await ctx.db
        .update(players)
        .set({ rails: player.rails + sellPrice })
        .where(eq(players.id, player.id));

      return { success: true, earned: sellPrice };
    }),

  throw: protectedProcedure
    .input(z.object({ userItemId: z.number(), count: z.number().min(1) }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [userArea] = await ctx.db
        .select()
        .from(userAreas)
        .where(eq(userAreas.playerId, player.id))
        .limit(1);
      if (!userArea) throw new Error("User area not found");

      const [ui] = await ctx.db
        .select()
        .from(userItems)
        .where(
          and(
            eq(userItems.id, input.userItemId),
            eq(userItems.playerId, player.id)
          )
        )
        .limit(1);
      if (!ui || ui.count < input.count) throw new Error("Not enough items");

      const newCount = ui.count - input.count;
      if (newCount <= 0) {
        await ctx.db.delete(userItems).where(eq(userItems.id, input.userItemId));
      } else {
        await ctx.db
          .update(userItems)
          .set({ count: newCount })
          .where(eq(userItems.id, input.userItemId));
      }

      await ctx.db.insert(thrownItems).values({
        areaNodeId: userArea.areaNodeId,
        itemId: ui.itemId,
        count: input.count,
        userItemId: ui.id,
      });

      return { success: true };
    }),

  pickup: protectedProcedure
    .input(z.object({ thrownItemId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [thrown] = await ctx.db
        .select()
        .from(thrownItems)
        .where(eq(thrownItems.id, input.thrownItemId))
        .limit(1);
      if (!thrown) throw new Error("Item not found");

      const [existing] = await ctx.db
        .select()
        .from(userItems)
        .where(
          and(
            eq(userItems.playerId, player.id),
            eq(userItems.itemId, thrown.itemId)
          )
        )
        .limit(1);

      if (existing) {
        await ctx.db
          .update(userItems)
          .set({ count: existing.count + thrown.count })
          .where(eq(userItems.id, existing.id));
      } else {
        await ctx.db.insert(userItems).values({
          playerId: player.id,
          itemId: thrown.itemId,
          count: thrown.count,
        });
      }

      await ctx.db
        .delete(thrownItems)
        .where(eq(thrownItems.id, input.thrownItemId));

      return { success: true };
    }),
});
