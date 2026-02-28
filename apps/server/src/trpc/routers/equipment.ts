import { z } from "zod";
import { eq, and } from "drizzle-orm";
import {
  players,
  items,
  userItems,
  equipment,
  userEquipments,
  userEquipmentAffixes,
  equipmentAffixes,
} from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

const BODY_REGION_MAP: Record<number, string> = {
  1: "rightHand",
  2: "leftHand",
  3: "bothHand",
  4: "body",
  5: "head",
  6: "leg",
  7: "neck",
  8: "belt",
  9: "amulet",
  10: "ringA",
  11: "ringB",
};

export const equipmentRouter = router({
  myEquipment: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) return null;

    const [equip] = await ctx.db
      .select()
      .from(userEquipments)
      .where(eq(userEquipments.playerId, player.id))
      .limit(1);
    if (!equip) return null;

    const slotKeys = [
      "rightHand", "leftHand", "bothHand", "body", "head",
      "leg", "neck", "belt", "amulet", "ringA", "ringB",
    ] as const;

    type SlotInfo = {
      userItemId: number;
      itemName: string;
      equipStats: { attack: number | null; defense: number | null; damageMin: number; damageMax: number | null } | null;
    };
    const resolvedSlots: Record<string, SlotInfo | null> = {};
    for (const slot of slotKeys) {
      const userItemId = equip[slot];
      if (!userItemId) {
        resolvedSlots[slot] = null;
        continue;
      }
      const [ui] = await ctx.db
        .select({ userItem: userItems, item: items })
        .from(userItems)
        .innerJoin(items, eq(userItems.itemId, items.id))
        .where(eq(userItems.id, userItemId))
        .limit(1);
      if (!ui) {
        resolvedSlots[slot] = null;
        continue;
      }
      const [equipRow] = await ctx.db
        .select()
        .from(equipment)
        .where(eq(equipment.itemId, ui.item.id))
        .limit(1);
      resolvedSlots[slot] = {
        userItemId,
        itemName: ui.item.name,
        equipStats: equipRow
          ? { attack: equipRow.attack, defense: equipRow.defense, damageMin: equipRow.damageMin, damageMax: equipRow.damageMax }
          : null,
      };
    }

    return { slots: resolvedSlots };
  }),

  availableEquipment: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) return [];

    const playerItems = await ctx.db
      .select({ userItem: userItems, item: items })
      .from(userItems)
      .innerJoin(items, eq(userItems.itemId, items.id))
      .where(eq(userItems.playerId, player.id));

    const equipmentItems = [];
    for (const pi of playerItems) {
      const [equip] = await ctx.db
        .select()
        .from(equipment)
        .where(eq(equipment.itemId, pi.item.id))
        .limit(1);
      if (equip) {
        const affixes = await ctx.db
          .select({
            userAffix: userEquipmentAffixes,
            affix: equipmentAffixes,
          })
          .from(userEquipmentAffixes)
          .innerJoin(
            equipmentAffixes,
            eq(userEquipmentAffixes.equipmentAffixId, equipmentAffixes.id)
          )
          .where(eq(userEquipmentAffixes.userItemId, pi.userItem.id));

        equipmentItems.push({
          ...pi,
          equipment: equip,
          affixes,
        });
      }
    }

    return equipmentItems;
  }),

  equip: protectedProcedure
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
      if (!ui) throw new Error("Item not found");

      const [equip] = await ctx.db
        .select()
        .from(equipment)
        .where(eq(equipment.itemId, ui.itemId))
        .limit(1);
      if (!equip) throw new Error("Not equipment");

      const slot = BODY_REGION_MAP[equip.bodyRegion];
      if (!slot) throw new Error("Invalid body region");

      await ctx.db
        .update(userEquipments)
        .set({ [slot]: ui.id })
        .where(eq(userEquipments.playerId, player.id));

      await ctx.db
        .update(userItems)
        .set({ equipped: 1 })
        .where(eq(userItems.id, input.userItemId));

      return { success: true };
    }),

  unequip: protectedProcedure
    .input(z.object({ slot: z.string() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [equip] = await ctx.db
        .select()
        .from(userEquipments)
        .where(eq(userEquipments.playerId, player.id))
        .limit(1);
      if (!equip) throw new Error("No equipment");

      const userItemId = (equip as Record<string, unknown>)[input.slot] as
        | number
        | null;
      if (userItemId) {
        await ctx.db
          .update(userItems)
          .set({ equipped: 0 })
          .where(eq(userItems.id, userItemId));
      }

      await ctx.db
        .update(userEquipments)
        .set({ [input.slot]: null })
        .where(eq(userEquipments.playerId, player.id));

      return { success: true };
    }),
});
