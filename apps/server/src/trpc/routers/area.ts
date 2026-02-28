import { z } from "zod";
import { eq } from "drizzle-orm";
import {
  areas,
  areaNodes,
  routes,
  players,
  userAreas,
  towns,
  roads,
  thrownItems,
  items,
} from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

export const areaRouter = router({
  current: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);

    if (!player) return null;

    const [userArea] = await ctx.db
      .select()
      .from(userAreas)
      .where(eq(userAreas.playerId, player.id))
      .limit(1);

    if (!userArea) return null;

    const [areaNode] = await ctx.db
      .select()
      .from(areaNodes)
      .where(eq(areaNodes.id, userArea.areaNodeId))
      .limit(1);

    if (!areaNode) return null;

    const [area] = await ctx.db
      .select()
      .from(areas)
      .where(eq(areas.id, areaNode.areaId))
      .limit(1);

    const connectedRoutes = await ctx.db
      .select()
      .from(routes)
      .where(eq(routes.areaNodeId, areaNode.id));

    const connectedNodes = await Promise.all(
      connectedRoutes.map(async (route) => {
        const [node] = await ctx.db
          .select()
          .from(areaNodes)
          .where(eq(areaNodes.id, route.connectedAreaNodeId))
          .limit(1);
        if (!node) return null;
        const [nodeArea] = await ctx.db
          .select()
          .from(areas)
          .where(eq(areas.id, node.areaId))
          .limit(1);
        return { node, area: nodeArea };
      })
    );

    const droppedItems = await ctx.db
      .select({
        thrownItem: thrownItems,
        item: items,
      })
      .from(thrownItems)
      .innerJoin(items, eq(thrownItems.itemId, items.id))
      .where(eq(thrownItems.areaNodeId, areaNode.id));

    let areaDetail = null;
    if (area) {
      if (area.areaType === 1) {
        const [town] = await ctx.db
          .select()
          .from(towns)
          .where(eq(towns.id, area.typeId))
          .limit(1);
        areaDetail = { type: "town" as const, data: town };
      } else if (area.areaType === 2) {
        const [road] = await ctx.db
          .select()
          .from(roads)
          .where(eq(roads.id, area.typeId))
          .limit(1);
        areaDetail = { type: "road" as const, data: road };
      }
    }

    return {
      area,
      areaNode,
      areaDetail,
      connectedNodes: connectedNodes.filter(Boolean),
      droppedItems,
    };
  }),

  move: protectedProcedure
    .input(z.object({ targetAreaNodeId: z.number() }))
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

      const validRoutes = await ctx.db
        .select()
        .from(routes)
        .where(eq(routes.areaNodeId, userArea.areaNodeId));

      const isValid = validRoutes.some(
        (r) => r.connectedAreaNodeId === input.targetAreaNodeId
      );

      if (!isValid) throw new Error("Cannot move to that area");

      await ctx.db
        .update(userAreas)
        .set({ areaNodeId: input.targetAreaNodeId })
        .where(eq(userAreas.playerId, player.id));

      return { success: true };
    }),

  get: protectedProcedure
    .input(z.object({ id: z.number() }))
    .query(async ({ ctx, input }) => {
      const [area] = await ctx.db
        .select()
        .from(areas)
        .where(eq(areas.id, input.id))
        .limit(1);
      return area ?? null;
    }),
});
