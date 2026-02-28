import { eq } from "drizzle-orm";
import { players, skills, userSkills } from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const skillRouter = router({
  list: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);
    if (!player) return [];

    const allSkills = await ctx.db.select().from(skills);
    const playerSkills = await ctx.db
      .select()
      .from(userSkills)
      .where(eq(userSkills.playerId, player.id));

    return allSkills.map((s) => {
      const us = playerSkills.find((ps) => ps.skillId === s.id);
      return { ...s, skillPoint: us?.skillPoint ?? 0 };
    });
  }),
});
