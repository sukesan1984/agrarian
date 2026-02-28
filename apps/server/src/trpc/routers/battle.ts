import { z } from "zod";
import { eq, and } from "drizzle-orm";
import {
  players,
  userAreas,
  areas,
  areaNodes,
  enemies,
  enemyMaps,
  enemyGroups,
  enemyInstances,
  userEncounterEnemyGroups,
  userEnemyHistories,
  levels,
} from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

function calculateDamage(
  attackerStr: number,
  defenderDefense: number,
  damageMin: number,
  damageMax: number
): number {
  const baseDamage =
    damageMin + Math.floor(Math.random() * (damageMax - damageMin + 1));
  const finalDamage = Math.max(1, baseDamage + attackerStr - defenderDefense);
  return finalDamage;
}

export const battleRouter = router({
  encounter: protectedProcedure.mutation(async ({ ctx }) => {
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

    const [areaNode] = await ctx.db
      .select()
      .from(areaNodes)
      .where(eq(areaNodes.id, userArea.areaNodeId))
      .limit(1);

    if (!areaNode) throw new Error("Area node not found");

    const [area] = await ctx.db
      .select()
      .from(areas)
      .where(eq(areas.id, areaNode.areaId))
      .limit(1);

    if (!area || !area.enemyRate) {
      return { encountered: false, enemyGroup: null };
    }

    const roll = Math.random() * 100;
    if (roll > area.enemyRate) {
      return { encountered: false, enemyGroup: null };
    }

    const areaEnemies = await ctx.db
      .select()
      .from(enemyMaps)
      .innerJoin(enemies, eq(enemyMaps.enemyId, enemies.id))
      .where(eq(enemyMaps.areaId, area.id));

    if (areaEnemies.length === 0) {
      return { encountered: false, enemyGroup: null };
    }

    const totalWeight = areaEnemies.reduce(
      (sum, e) => sum + e.enemy_maps.weight,
      0
    );
    let pick = Math.random() * totalWeight;
    let selectedEnemy = areaEnemies[0].enemies;

    for (const ae of areaEnemies) {
      pick -= ae.enemy_maps.weight;
      if (pick <= 0) {
        selectedEnemy = ae.enemies;
        break;
      }
    }

    const enemyCount = area.enemyNum
      ? Math.floor(Math.random() * area.enemyNum) + 1
      : 1;

    const [group] = await ctx.db
      .insert(enemyGroups)
      .values({
        areaNodeId: areaNode.id,
        status: 1,
        playerNum: 1,
      })
      .returning();

    const instances = [];
    for (let i = 0; i < enemyCount; i++) {
      const [inst] = await ctx.db
        .insert(enemyInstances)
        .values({
          enemyGroupId: group.id,
          enemyId: selectedEnemy.id,
          currentHp: selectedEnemy.hp,
        })
        .returning();
      instances.push({ ...inst, enemy: selectedEnemy });
    }

    await ctx.db.insert(userEncounterEnemyGroups).values({
      playerId: player.id,
      enemyGroupId: group.id,
    });

    return {
      encountered: true,
      enemyGroup: { ...group, instances },
    };
  }),

  attack: protectedProcedure.mutation(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);

    if (!player) throw new Error("Player not found");

    const [encounter] = await ctx.db
      .select()
      .from(userEncounterEnemyGroups)
      .where(eq(userEncounterEnemyGroups.playerId, player.id))
      .limit(1);

    if (!encounter) throw new Error("No active battle");

    const instances = await ctx.db
      .select()
      .from(enemyInstances)
      .innerJoin(enemies, eq(enemyInstances.enemyId, enemies.id))
      .where(eq(enemyInstances.enemyGroupId, encounter.enemyGroupId));

    const aliveEnemies = instances.filter(
      (i) => i.enemy_instances.currentHp > 0
    );

    if (aliveEnemies.length === 0) {
      return { battleEnd: true, victory: true, log: [], rewards: null };
    }

    const log: string[] = [];
    let playerHp = player.hp;
    const playerDamageMin = Math.max(1, player.str);
    const playerDamageMax = Math.max(2, player.str * 2);

    for (const inst of aliveEnemies) {
      const target = inst.enemy_instances;
      const enemy = inst.enemies;

      const dmg = calculateDamage(
        player.str,
        enemy.defense,
        playerDamageMin,
        playerDamageMax
      );
      const newHp = Math.max(0, target.currentHp - dmg);

      await ctx.db
        .update(enemyInstances)
        .set({ currentHp: newHp })
        .where(eq(enemyInstances.id, target.id));

      log.push(`${player.name}の攻撃！${enemy.name}に${dmg}のダメージ！`);

      if (newHp <= 0) {
        log.push(`${enemy.name}を倒した！`);
        continue;
      }

      const enemyDmg = calculateDamage(
        enemy.str,
        0,
        enemy.damageMin,
        enemy.damageMax
      );
      playerHp = Math.max(0, playerHp - enemyDmg);
      log.push(`${enemy.name}の攻撃！${player.name}に${enemyDmg}のダメージ！`);

      if (playerHp <= 0) {
        await ctx.db
          .update(players)
          .set({ hp: 0 })
          .where(eq(players.id, player.id));

        await ctx.db
          .delete(userEncounterEnemyGroups)
          .where(eq(userEncounterEnemyGroups.playerId, player.id));

        log.push(`${player.name}は力尽きた...`);
        return { battleEnd: true, victory: false, log, rewards: null };
      }
      break;
    }

    await ctx.db
      .update(players)
      .set({ hp: playerHp })
      .where(eq(players.id, player.id));

    const remainingAlive = aliveEnemies.filter((i) => {
      const target = i.enemy_instances;
      const dmg = calculateDamage(
        player.str,
        i.enemies.defense,
        playerDamageMin,
        playerDamageMax
      );
      return target.currentHp - dmg > 0;
    });

    const updatedInstances = await ctx.db
      .select()
      .from(enemyInstances)
      .where(eq(enemyInstances.enemyGroupId, encounter.enemyGroupId));

    const allDead = updatedInstances.every((i) => i.currentHp <= 0);

    if (allDead) {
      const totalExp = instances.reduce(
        (sum, i) => sum + (i.enemies.exp ?? 0),
        0
      );
      const totalRails = instances.reduce(
        (sum, i) => sum + (i.enemies.rails ?? 0),
        0
      );

      const newExp = player.exp + totalExp;
      const [levelData] = await ctx.db
        .select()
        .from(levels)
        .where(eq(levels.level, 1))
        .limit(1);

      let newRemainingPoints = player.remainingPoints;
      const allLevels = await ctx.db.select().from(levels);
      const currentLevel =
        allLevels.find((l) => player.exp >= l.expMin && player.exp <= l.expMax)
          ?.level ?? 1;
      const newLevel =
        allLevels.find((l) => newExp >= l.expMin && newExp <= l.expMax)
          ?.level ?? currentLevel;

      if (newLevel > currentLevel) {
        newRemainingPoints += (newLevel - currentLevel) * 5;
        log.push(`レベルアップ！ Lv.${currentLevel} → Lv.${newLevel}`);
      }

      await ctx.db
        .update(players)
        .set({
          exp: newExp,
          rails: player.rails + totalRails,
          remainingPoints: newRemainingPoints,
        })
        .where(eq(players.id, player.id));

      await ctx.db
        .delete(userEncounterEnemyGroups)
        .where(eq(userEncounterEnemyGroups.playerId, player.id));

      return {
        battleEnd: true,
        victory: true,
        log,
        rewards: {
          exp: totalExp,
          rails: totalRails,
          levelUp: newLevel > currentLevel ? newLevel : null,
        },
      };
    }

    return {
      battleEnd: false,
      victory: false,
      log,
      rewards: null,
      playerHp,
      enemies: updatedInstances,
    };
  }),

  escape: protectedProcedure.mutation(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);

    if (!player) throw new Error("Player not found");

    const escaped = Math.random() > 0.3;

    if (escaped) {
      await ctx.db
        .delete(userEncounterEnemyGroups)
        .where(eq(userEncounterEnemyGroups.playerId, player.id));
    }

    return { escaped };
  }),

  status: protectedProcedure.query(async ({ ctx }) => {
    const [player] = await ctx.db
      .select()
      .from(players)
      .where(eq(players.userId, ctx.user.id))
      .limit(1);

    if (!player) return null;

    const [encounter] = await ctx.db
      .select()
      .from(userEncounterEnemyGroups)
      .where(eq(userEncounterEnemyGroups.playerId, player.id))
      .limit(1);

    if (!encounter) return null;

    const instances = await ctx.db
      .select()
      .from(enemyInstances)
      .innerJoin(enemies, eq(enemyInstances.enemyId, enemies.id))
      .where(eq(enemyInstances.enemyGroupId, encounter.enemyGroupId));

    return {
      enemyGroupId: encounter.enemyGroupId,
      enemies: instances.map((i) => ({
        ...i.enemy_instances,
        enemy: i.enemies,
      })),
    };
  }),
});
