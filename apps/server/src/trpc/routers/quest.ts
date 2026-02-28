import { z } from "zod";
import { eq, and } from "drizzle-orm";
import {
  players,
  quests,
  questConditions,
  userQuests,
  userProgresses,
  gifts,
  userItems,
} from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

async function checkQuestConditions(
  db: any,
  questId: number,
  playerId: number
): Promise<{ met: boolean; conditions: { description: string; current: number; required: number }[] }> {
  const conditions = await db
    .select()
    .from(questConditions)
    .where(eq(questConditions.questId, questId));

  if (conditions.length === 0) return { met: true, conditions: [] };

  const results = [];
  let allMet = true;

  for (const cond of conditions) {
    const [progress] = await db
      .select()
      .from(userProgresses)
      .where(
        and(
          eq(userProgresses.playerId, playerId),
          eq(userProgresses.progressType, cond.conditionType),
          eq(userProgresses.progressId, cond.conditionId)
        )
      )
      .limit(1);

    const current = progress?.count ?? 0;
    const required = cond.conditionValue;
    if (current < required) allMet = false;

    const typeLabel = cond.conditionType === 1 ? "討伐" : "収集";
    results.push({
      description: `${typeLabel} #${cond.conditionId}`,
      current,
      required,
    });
  }

  return { met: allMet, conditions: results };
}

export const questRouter = router({
  list: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) return [];

    const allQuests = await ctx.db.select().from(quests);
    const playerQuests = await ctx.db
      .select()
      .from(userQuests)
      .where(eq(userQuests.playerId, player.id));

    return Promise.all(
      allQuests.map(async (q) => {
        const uq = playerQuests.find((pq) => pq.questId === q.id);
        const status = uq?.status ?? 0;
        const { met: conditionsMet, conditions } =
          status === 1
            ? await checkQuestConditions(ctx.db, q.id, player.id)
            : { met: false, conditions: [] };
        return { ...q, status, conditionsMet, conditions };
      })
    );
  }),

  accept: protectedProcedure
    .input(z.object({ questId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [quest] = await ctx.db
        .select()
        .from(quests)
        .where(eq(quests.id, input.questId))
        .limit(1);
      if (!quest) throw new Error("Quest not found");

      const [existing] = await ctx.db
        .select()
        .from(userQuests)
        .where(
          and(
            eq(userQuests.playerId, player.id),
            eq(userQuests.questId, input.questId)
          )
        )
        .limit(1);
      if (existing) throw new Error("Quest already accepted");

      await ctx.db.insert(userQuests).values({
        playerId: player.id,
        questId: input.questId,
        status: 1,
      });

      return { success: true };
    }),

  claim: protectedProcedure
    .input(z.object({ questId: z.number() }))
    .mutation(async ({ ctx, input }) => {
      const [player] = await ctx.db
        .select()
        .from(players)
        .where(eq(players.userId, ctx.user.id))
        .limit(1);
      if (!player) throw new Error("Player not found");

      const [uq] = await ctx.db
        .select()
        .from(userQuests)
        .where(
          and(
            eq(userQuests.playerId, player.id),
            eq(userQuests.questId, input.questId)
          )
        )
        .limit(1);
      if (!uq || uq.status !== 1) throw new Error("Quest not in progress");

      const { met } = await checkQuestConditions(ctx.db, input.questId, player.id);
      if (!met) throw new Error("Quest conditions not met");

      const [quest] = await ctx.db
        .select()
        .from(quests)
        .where(eq(quests.id, input.questId))
        .limit(1);
      if (!quest) throw new Error("Quest not found");

      if (quest.rewardGiftId) {
        const [gift] = await ctx.db
          .select()
          .from(gifts)
          .where(eq(gifts.id, quest.rewardGiftId))
          .limit(1);
        if (gift) {
          const [existing] = await ctx.db
            .select()
            .from(userItems)
            .where(
              and(
                eq(userItems.playerId, player.id),
                eq(userItems.itemId, gift.itemId)
              )
            )
            .limit(1);

          if (existing) {
            await ctx.db
              .update(userItems)
              .set({ count: existing.count + gift.count })
              .where(eq(userItems.id, existing.id));
          } else {
            await ctx.db.insert(userItems).values({
              playerId: player.id,
              itemId: gift.itemId,
              count: gift.count,
            });
          }
        }
      }

      await ctx.db
        .update(userQuests)
        .set({ status: 2 })
        .where(
          and(
            eq(userQuests.playerId, player.id),
            eq(userQuests.questId, input.questId)
          )
        );

      return { success: true };
    }),
});
