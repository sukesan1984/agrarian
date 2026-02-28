import { z } from "zod";
import { eq } from "drizzle-orm";
import { players, dungeons, userDungeons } from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const dungeonRouter = router({
  status: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) return null;

    const [ud] = await ctx.db
      .select({ userDungeon: userDungeons, dungeon: dungeons })
      .from(userDungeons)
      .innerJoin(dungeons, eq(userDungeons.dungeonId, dungeons.id))
      .where(eq(userDungeons.playerId, player.id))
      .limit(1);

    return ud ?? null;
  }),

  enter: protectedProcedure
    .input(z.object({ dungeonId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [dungeon] = await ctx.db
        .select()
        .from(dungeons)
        .where(eq(dungeons.id, input.dungeonId))
        .limit(1);
      if (!dungeon) throw new Error("Dungeon not found");

      await ctx.db
        .delete(userDungeons)
        .where(eq(userDungeons.playerId, player.id));

      const [ud] = await ctx.db
        .insert(userDungeons)
        .values({
          playerId: player.id,
          dungeonId: dungeon.id,
          currentFloor: 1,
          searchCount: 0,
          foundFootstep: false,
        })
        .returning();

      return { userDungeon: ud, dungeon };
    }),

  search: protectedProcedure.mutation(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) throw new Error("Player not found");

    const [ud] = await ctx.db
      .select({ userDungeon: userDungeons, dungeon: dungeons })
      .from(userDungeons)
      .innerJoin(dungeons, eq(userDungeons.dungeonId, dungeons.id))
      .where(eq(userDungeons.playerId, player.id))
      .limit(1);
    if (!ud) throw new Error("Not in dungeon");

    const newSearchCount = ud.userDungeon.searchCount + 1;
    const requiredSearches =
      ud.dungeon.minSearch +
      Math.floor(
        Math.random() * (ud.dungeon.maxSearch - ud.dungeon.minSearch + 1)
      );

    const found = newSearchCount >= requiredSearches;

    await ctx.db
      .update(userDungeons)
      .set({
        searchCount: newSearchCount,
        foundFootstep: found,
      })
      .where(eq(userDungeons.playerId, player.id));

    return {
      searchCount: newSearchCount,
      foundFootstep: found,
      message: found ? "階段を見つけた！" : "何も見つからなかった...",
    };
  }),

  ascend: protectedProcedure.mutation(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) throw new Error("Player not found");

    const [ud] = await ctx.db
      .select({ userDungeon: userDungeons, dungeon: dungeons })
      .from(userDungeons)
      .innerJoin(dungeons, eq(userDungeons.dungeonId, dungeons.id))
      .where(eq(userDungeons.playerId, player.id))
      .limit(1);
    if (!ud) throw new Error("Not in dungeon");
    if (!ud.userDungeon.foundFootstep) throw new Error("No stairs found");

    const newFloor = ud.userDungeon.currentFloor + 1;

    if (newFloor > ud.dungeon.maxFloor) {
      await ctx.db
        .delete(userDungeons)
        .where(eq(userDungeons.playerId, player.id));
      return { cleared: true, floor: newFloor };
    }

    await ctx.db
      .update(userDungeons)
      .set({
        currentFloor: newFloor,
        searchCount: 0,
        foundFootstep: false,
      })
      .where(eq(userDungeons.playerId, player.id));

    return { cleared: false, floor: newFloor };
  }),

  escape: protectedProcedure.mutation(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) throw new Error("Player not found");

    await ctx.db
      .delete(userDungeons)
      .where(eq(userDungeons.playerId, player.id));

    return { success: true };
  }),
});
