import { z } from "zod";
import { eq, and, inArray } from "drizzle-orm";
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
  userEquipments,
  userItems,
  items,
  equipment,
  itemLotteries,
} from "@agrarian/db";
import { router, protectedProcedure } from "../trpc";

function randomInt(min: number, max: number): number {
  return min + Math.floor(Math.random() * (max - min + 1));
}

function calculateDamage(
  attackerStr: number,
  defenderDefense: number,
  damageMin: number,
  damageMax: number,
  weaponAttack: number = 0
): number {
  const baseDamage = randomInt(damageMin, damageMax);
  return Math.max(1, baseDamage + weaponAttack + attackerStr - defenderDefense);
}

interface EquipStats {
  weaponAttack: number;
  weaponDamageMin: number;
  weaponDamageMax: number;
  totalDefense: number;
}

async function getPlayerEquipStats(
  db: any,
  playerId: number
): Promise<EquipStats> {
  const result: EquipStats = {
    weaponAttack: 0,
    weaponDamageMin: 0,
    weaponDamageMax: 0,
    totalDefense: 0,
  };

  const [equip] = await db
    .select()
    .from(userEquipments)
    .where(eq(userEquipments.playerId, playerId))
    .limit(1);

  if (!equip) return result;

  const weaponSlots = ["rightHand", "leftHand", "bothHand"] as const;
  const allSlots = [
    "rightHand",
    "leftHand",
    "bothHand",
    "body",
    "head",
    "leg",
    "neck",
    "belt",
    "amulet",
    "ringA",
    "ringB",
  ] as const;

  const equippedUserItemIds: number[] = [];
  for (const slot of allSlots) {
    const val = equip[slot];
    if (val) equippedUserItemIds.push(val);
  }

  if (equippedUserItemIds.length === 0) return result;

  const equippedItems = await db
    .select({ userItem: userItems, item: items })
    .from(userItems)
    .innerJoin(items, eq(userItems.itemId, items.id))
    .where(inArray(userItems.id, equippedUserItemIds));

  for (const ei of equippedItems) {
    const [equipRow] = await db
      .select()
      .from(equipment)
      .where(eq(equipment.itemId, ei.item.id))
      .limit(1);

    if (!equipRow) continue;

    const isWeapon = weaponSlots.some(
      (s) => equip[s] === ei.userItem.id
    );

    if (isWeapon) {
      result.weaponAttack += equipRow.attack ?? 0;
      result.weaponDamageMin += equipRow.damageMin ?? 0;
      result.weaponDamageMax += equipRow.damageMax ?? 0;
    }

    result.totalDefense += equipRow.defense ?? 0;
  }

  return result;
}

export type BattleEvent =
  | { type: "playerAttack"; targetId: number; enemyName: string; damage: number; critical: boolean; enemyHp: number; enemyMaxHp: number; killed: boolean }
  | { type: "enemyAttack"; attackerId: number; enemyName: string; damage: number; playerHp: number; playerMaxHp: number }
  | { type: "playerDefeated" }
  | { type: "victory"; exp: number; rails: number; levelUp: number | null; drops: { itemName: string; count: number }[] }
  | { type: "message"; text: string };

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
      return {
        battleEnd: true,
        victory: true,
        log: [] as string[],
        events: [] as BattleEvent[],
        rewards: null,
      };
    }

    const equipStats = await getPlayerEquipStats(ctx.db, player.id);

    const hasWeapon =
      equipStats.weaponDamageMin > 0 || equipStats.weaponDamageMax > 0;
    const playerDamageMin = hasWeapon
      ? equipStats.weaponDamageMin
      : Math.max(1, player.str);
    const playerDamageMax = hasWeapon
      ? equipStats.weaponDamageMax
      : Math.max(2, player.str * 2);
    const weaponAttack = equipStats.weaponAttack;

    const log: string[] = [];
    const events: BattleEvent[] = [];
    let playerHp = player.hp;

    // --- Player attack phase: attack all alive enemies ---
    const hpAfterAttacks: Map<number, number> = new Map();
    for (const inst of aliveEnemies) {
      const target = inst.enemy_instances;
      const enemy = inst.enemies;

      const dmg = calculateDamage(
        player.str,
        enemy.defense,
        playerDamageMin,
        playerDamageMax,
        weaponAttack
      );
      const newHp = Math.max(0, target.currentHp - dmg);
      hpAfterAttacks.set(target.id, newHp);

      await ctx.db
        .update(enemyInstances)
        .set({ currentHp: newHp })
        .where(eq(enemyInstances.id, target.id));

      const killed = newHp <= 0;
      log.push(
        `${player.name}の攻撃！${enemy.name}に${dmg}のダメージ！${killed ? `${enemy.name}を倒した！` : ""}`
      );
      events.push({
        type: "playerAttack",
        targetId: target.id,
        enemyName: enemy.name,
        damage: dmg,
        critical: false,
        enemyHp: newHp,
        enemyMaxHp: enemy.hp,
        killed,
      });
    }

    // --- Enemy counter-attack phase: surviving enemies attack back ---
    for (const inst of aliveEnemies) {
      const target = inst.enemy_instances;
      const enemy = inst.enemies;

      const remainingHp = hpAfterAttacks.get(target.id) ?? 0;
      if (remainingHp <= 0) continue;

      const enemyDmg = calculateDamage(
        enemy.str,
        equipStats.totalDefense,
        enemy.damageMin,
        enemy.damageMax
      );
      playerHp = Math.max(0, playerHp - enemyDmg);

      log.push(`${enemy.name}の攻撃！${player.name}に${enemyDmg}のダメージ！`);
      events.push({
        type: "enemyAttack",
        attackerId: target.id,
        enemyName: enemy.name,
        damage: enemyDmg,
        playerHp,
        playerMaxHp: player.hpMax,
      });

      if (playerHp <= 0) {
        await ctx.db
          .update(players)
          .set({ hp: 0 })
          .where(eq(players.id, player.id));

        await ctx.db
          .delete(userEncounterEnemyGroups)
          .where(eq(userEncounterEnemyGroups.playerId, player.id));

        log.push(`${player.name}は力尽きた...`);
        events.push({ type: "playerDefeated" });
        return { battleEnd: true, victory: false, log, events, rewards: null };
      }
    }

    await ctx.db
      .update(players)
      .set({ hp: playerHp })
      .where(eq(players.id, player.id));

    // --- Check if all enemies dead ---
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
      let newRemainingPoints = player.remainingPoints;
      const allLevels = await ctx.db.select().from(levels);
      const currentLevel =
        allLevels.find(
          (l) => player.exp >= l.expMin && player.exp <= l.expMax
        )?.level ?? 1;
      const newLevel =
        allLevels.find((l) => newExp >= l.expMin && newExp <= l.expMax)
          ?.level ?? currentLevel;

      if (newLevel > currentLevel) {
        newRemainingPoints += (newLevel - currentLevel) * 5;
        log.push(`レベルアップ！ Lv.${currentLevel} → Lv.${newLevel}`);
      }

      // --- Item drop logic ---
      const drops: { itemName: string; count: number }[] = [];
      for (const inst of instances) {
        const enemy = inst.enemies;
        if (!enemy.dropItemRate || enemy.dropItemRate <= 0) continue;
        if (!enemy.itemLotteryGroupId || enemy.itemLotteryGroupId <= 0)
          continue;

        const dropRoll = Math.random() * 100;
        if (dropRoll > enemy.dropItemRate) continue;

        const lotteries = await ctx.db
          .select()
          .from(itemLotteries)
          .where(eq(itemLotteries.groupId, enemy.itemLotteryGroupId));

        if (lotteries.length === 0) continue;

        const lotteryTotalWeight = lotteries.reduce(
          (sum, l) => sum + l.weight,
          0
        );
        let lotteryPick = Math.random() * lotteryTotalWeight;
        let selectedLottery = lotteries[0];

        for (const l of lotteries) {
          lotteryPick -= l.weight;
          if (lotteryPick <= 0) {
            selectedLottery = l;
            break;
          }
        }

        const [existingUserItem] = await ctx.db
          .select()
          .from(userItems)
          .where(
            and(
              eq(userItems.playerId, player.id),
              eq(userItems.itemId, selectedLottery.itemId)
            )
          )
          .limit(1);

        if (existingUserItem) {
          await ctx.db
            .update(userItems)
            .set({ count: existingUserItem.count + selectedLottery.count })
            .where(eq(userItems.id, existingUserItem.id));
        } else {
          await ctx.db.insert(userItems).values({
            playerId: player.id,
            itemId: selectedLottery.itemId,
            count: selectedLottery.count,
          });
        }

        const [droppedItem] = await ctx.db
          .select()
          .from(items)
          .where(eq(items.id, selectedLottery.itemId))
          .limit(1);

        const existingDrop = drops.find(
          (d) => d.itemName === (droppedItem?.name ?? "不明")
        );
        if (existingDrop) {
          existingDrop.count += selectedLottery.count;
        } else {
          drops.push({
            itemName: droppedItem?.name ?? "不明",
            count: selectedLottery.count,
          });
        }

        log.push(
          `${enemy.name}が${droppedItem?.name ?? "アイテム"} x${selectedLottery.count}をドロップした！`
        );
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

      events.push({
        type: "victory",
        exp: totalExp,
        rails: totalRails,
        levelUp: newLevel > currentLevel ? newLevel : null,
        drops,
      });

      return {
        battleEnd: true,
        victory: true,
        log,
        events,
        rewards: {
          exp: totalExp,
          rails: totalRails,
          levelUp: newLevel > currentLevel ? newLevel : null,
          drops,
        },
      };
    }

    return {
      battleEnd: false,
      victory: false,
      log,
      events,
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

    const battleInstances = await ctx.db
      .select()
      .from(enemyInstances)
      .innerJoin(enemies, eq(enemyInstances.enemyId, enemies.id))
      .where(eq(enemyInstances.enemyGroupId, encounter.enemyGroupId));

    return {
      enemyGroupId: encounter.enemyGroupId,
      enemies: battleInstances.map((i) => ({
        ...i.enemy_instances,
        enemy: i.enemies,
      })),
    };
  }),
});
