import "dotenv/config";
import { createDb } from "./index";
import { levels } from "./schema/levels";
import { towns, establishments } from "./schema/towns";
import { roads } from "./schema/roads";
import { areas, areaNodes, routes } from "./schema/areas";
import { items } from "./schema/items";
import { equipment } from "./schema/equipment";
import { enemies, enemyMaps } from "./schema/enemies";
import { shops, shopProducts, showcases } from "./schema/shops";
import { inns } from "./schema/inns";
import { resources } from "./schema/resources";
import { dungeons } from "./schema/dungeons";
import { skills } from "./schema/skills";
import { soldiers } from "./schema/soldiers";
import { quests, questConditions } from "./schema/quests";
import { recipes } from "./schema/recipes";

const db = createDb(process.env.DATABASE_URL!);

async function seed() {
  console.log("Seeding database...");

  // --- Levels ---
  const levelData = Array.from({ length: 100 }, (_, i) => ({
    level: i + 1,
    expMin: Math.floor(Math.pow(i, 2.5) * 10),
    expMax: Math.floor(Math.pow(i + 1, 2.5) * 10) - 1,
  }));
  await db.insert(levels).values(levelData).onConflictDoNothing();
  console.log("  Inserted levels");

  // --- Towns ---
  const [town1] = await db
    .insert(towns)
    .values([
      { name: "始まりの町" },
      { name: "交易の町アルマ" },
      { name: "港町マリナ" },
    ])
    .onConflictDoNothing()
    .returning();
  console.log("  Inserted towns");

  // --- Roads ---
  const [road1] = await db
    .insert(roads)
    .values([
      { name: "草原の道", roadLength: 3 },
      { name: "森の小道", roadLength: 4 },
      { name: "山岳路", roadLength: 5 },
    ])
    .onConflictDoNothing()
    .returning();
  console.log("  Inserted roads");

  // --- Inns ---
  await db
    .insert(inns)
    .values([
      { name: "旅人の宿", description: "温かいベッドで体力を回復できます", rails: 10 },
      { name: "港の宿屋", description: "海風が心地よい宿", rails: 25 },
    ])
    .onConflictDoNothing();
  console.log("  Inserted inns");

  // --- Areas (areaType: 1=town, 2=road) ---
  const insertedAreas = await db
    .insert(areas)
    .values([
      { areaType: 1, typeId: 1 },                             // Area 1: 始まりの町
      { areaType: 2, typeId: 1, enemyRate: 30, enemyNum: 2 }, // Area 2: 草原の道
      { areaType: 2, typeId: 2, enemyRate: 50, enemyNum: 3 }, // Area 3: 森の小道
      { areaType: 1, typeId: 2 },                             // Area 4: 交易の町
      { areaType: 2, typeId: 3, enemyRate: 70, enemyNum: 3 }, // Area 5: 山岳路
      { areaType: 1, typeId: 3 },                             // Area 6: 港町
    ])
    .onConflictDoNothing()
    .returning();
  console.log("  Inserted areas");

  // --- Area Nodes ---
  const insertedNodes = await db
    .insert(areaNodes)
    .values([
      { areaId: insertedAreas[0].id, nodePoint: 1 }, // Node 1: 始まりの町
      { areaId: insertedAreas[1].id, nodePoint: 1 }, // Node 2: 草原の道 入口
      { areaId: insertedAreas[1].id, nodePoint: 2 }, // Node 3: 草原の道 出口
      { areaId: insertedAreas[2].id, nodePoint: 1 }, // Node 4: 森の小道 入口
      { areaId: insertedAreas[2].id, nodePoint: 2 }, // Node 5: 森の小道 出口
      { areaId: insertedAreas[3].id, nodePoint: 1 }, // Node 6: 交易の町
      { areaId: insertedAreas[4].id, nodePoint: 1 }, // Node 7: 山岳路 入口
      { areaId: insertedAreas[4].id, nodePoint: 2 }, // Node 8: 山岳路 出口
      { areaId: insertedAreas[5].id, nodePoint: 1 }, // Node 9: 港町
    ])
    .onConflictDoNothing()
    .returning();
  console.log("  Inserted area nodes");

  // --- Routes (bidirectional) ---
  const routePairs = [
    [0, 1], // 始まりの町 ↔ 草原の道 入口
    [1, 2], // 草原の道 入口 ↔ 草原の道 出口
    [2, 5], // 草原の道 出口 ↔ 交易の町
    [0, 3], // 始まりの町 ↔ 森の小道 入口
    [3, 4], // 森の小道 入口 ↔ 森の小道 出口
    [4, 5], // 森の小道 出口 ↔ 交易の町
    [5, 6], // 交易の町 ↔ 山岳路 入口
    [6, 7], // 山岳路 入口 ↔ 山岳路 出口
    [7, 8], // 山岳路 出口 ↔ 港町
  ];
  const routeValues = routePairs.flatMap(([a, b]) => [
    { areaNodeId: insertedNodes[a].id, connectedAreaNodeId: insertedNodes[b].id },
    { areaNodeId: insertedNodes[b].id, connectedAreaNodeId: insertedNodes[a].id },
  ]);
  await db.insert(routes).values(routeValues).onConflictDoNothing();
  console.log("  Inserted routes");

  // --- Items ---
  const insertedItems = await db
    .insert(items)
    .values([
      { name: "薬草", description: "HPを20回復する", itemType: 1, itemTypeId: 1, purchasePrice: 10, sellPrice: 5 },
      { name: "回復薬", description: "HPを50回復する", itemType: 1, itemTypeId: 2, purchasePrice: 30, sellPrice: 15 },
      { name: "木の剣", description: "初心者用の剣", itemType: 2, itemTypeId: 1, purchasePrice: 50, sellPrice: 25 },
      { name: "革の鎧", description: "軽量な防具", itemType: 2, itemTypeId: 2, purchasePrice: 80, sellPrice: 40 },
      { name: "鉄の剣", description: "標準的な剣", itemType: 2, itemTypeId: 3, purchasePrice: 200, sellPrice: 100 },
      { name: "鋼の盾", description: "頑丈な盾", itemType: 2, itemTypeId: 4, purchasePrice: 150, sellPrice: 75 },
      { name: "革のヘルム", description: "革製の兜", itemType: 2, itemTypeId: 5, purchasePrice: 60, sellPrice: 30 },
      { name: "スライムゼリー", description: "スライムが落とす素材", itemType: 3, purchasePrice: 5, sellPrice: 2 },
      { name: "ゴブリンの牙", description: "ゴブリンが落とす素材", itemType: 3, purchasePrice: 8, sellPrice: 4 },
      { name: "狼の毛皮", description: "狼が落とす素材", itemType: 3, purchasePrice: 15, sellPrice: 7 },
      { name: "鉄鉱石", description: "鍛冶に使う素材", itemType: 3, purchasePrice: 20, sellPrice: 10 },
      { name: "鋼の剣", description: "上質な剣", itemType: 2, itemTypeId: 6, purchasePrice: 500, sellPrice: 250 },
      { name: "チェインメイル", description: "鎖帷子の鎧", itemType: 2, itemTypeId: 7, purchasePrice: 400, sellPrice: 200 },
    ])
    .onConflictDoNothing()
    .returning();
  console.log("  Inserted items");

  // --- Equipment (bodyRegion: 1=rightHand, 2=leftHand, 4=body, 5=head) ---
  await db
    .insert(equipment)
    .values([
      { itemId: insertedItems[2].id, bodyRegion: 1, attack: 5, damageMin: 3, damageMax: 8, defense: 0 },
      { itemId: insertedItems[3].id, bodyRegion: 4, attack: 0, damageMin: 0, damageMax: 0, defense: 3 },
      { itemId: insertedItems[4].id, bodyRegion: 1, attack: 12, damageMin: 8, damageMax: 16, defense: 0 },
      { itemId: insertedItems[5].id, bodyRegion: 2, attack: 0, damageMin: 0, damageMax: 0, defense: 8 },
      { itemId: insertedItems[6].id, bodyRegion: 5, attack: 0, damageMin: 0, damageMax: 0, defense: 2 },
      { itemId: insertedItems[11].id, bodyRegion: 1, attack: 25, damageMin: 15, damageMax: 30, defense: 0 },
      { itemId: insertedItems[12].id, bodyRegion: 4, attack: 0, damageMin: 0, damageMax: 0, defense: 12 },
    ])
    .onConflictDoNothing();
  console.log("  Inserted equipment");

  // --- Enemies ---
  const insertedEnemies = await db
    .insert(enemies)
    .values([
      { name: "スライム", description: "弱い魔物", str: 3, defense: 1, hp: 15, rails: 5, exp: 5, level: 1, dex: 1, damageMin: 1, damageMax: 4 },
      { name: "ゴブリン", description: "小さな緑の魔物", str: 6, defense: 2, hp: 25, rails: 10, exp: 10, level: 2, dex: 3, damageMin: 3, damageMax: 7 },
      { name: "オオカミ", description: "素早い獣", str: 8, defense: 3, hp: 30, rails: 15, exp: 15, level: 3, dex: 6, damageMin: 5, damageMax: 10, criticalHitChance: 10, criticalHitDamage: 150 },
      { name: "オーク", description: "力の強い大型の魔物", str: 15, defense: 8, hp: 60, rails: 30, exp: 30, level: 5, dex: 3, damageMin: 10, damageMax: 20 },
      { name: "トロール", description: "巨大な魔物", str: 20, defense: 12, hp: 100, rails: 50, exp: 50, level: 8, dex: 2, damageMin: 15, damageMax: 30, damageReduction: 5 },
    ])
    .onConflictDoNothing()
    .returning();
  console.log("  Inserted enemies");

  // --- Enemy Maps ---
  await db
    .insert(enemyMaps)
    .values([
      { areaId: insertedAreas[1].id, enemyId: insertedEnemies[0].id, weight: 70 }, // 草原: スライム
      { areaId: insertedAreas[1].id, enemyId: insertedEnemies[1].id, weight: 30 }, // 草原: ゴブリン
      { areaId: insertedAreas[2].id, enemyId: insertedEnemies[1].id, weight: 40 }, // 森: ゴブリン
      { areaId: insertedAreas[2].id, enemyId: insertedEnemies[2].id, weight: 60 }, // 森: オオカミ
      { areaId: insertedAreas[4].id, enemyId: insertedEnemies[3].id, weight: 60 }, // 山岳: オーク
      { areaId: insertedAreas[4].id, enemyId: insertedEnemies[4].id, weight: 40 }, // 山岳: トロール
    ])
    .onConflictDoNothing();
  console.log("  Inserted enemy maps");

  // --- Shops ---
  const insertedShops = await db
    .insert(shops)
    .values([
      { name: "始まりの武器屋", description: "初心者向けの装備が揃う店" },
      { name: "アルマの道具屋", description: "冒険に必要な道具を取り扱う店" },
    ])
    .onConflictDoNothing()
    .returning();

  await db
    .insert(shopProducts)
    .values([
      { shopId: insertedShops[0].id, itemId: insertedItems[0].id, count: 99 },  // 薬草
      { shopId: insertedShops[0].id, itemId: insertedItems[1].id, count: 99 },  // 回復薬
      { shopId: insertedShops[0].id, itemId: insertedItems[2].id, count: 10 },  // 木の剣
      { shopId: insertedShops[0].id, itemId: insertedItems[3].id, count: 10 },  // 革の鎧
      { shopId: insertedShops[0].id, itemId: insertedItems[6].id, count: 10 },  // 革のヘルム
      { shopId: insertedShops[1].id, itemId: insertedItems[0].id, count: 99 },  // 薬草
      { shopId: insertedShops[1].id, itemId: insertedItems[1].id, count: 99 },  // 回復薬
      { shopId: insertedShops[1].id, itemId: insertedItems[4].id, count: 5 },   // 鉄の剣
      { shopId: insertedShops[1].id, itemId: insertedItems[5].id, count: 5 },   // 鋼の盾
    ])
    .onConflictDoNothing();
  console.log("  Inserted shops and products");

  // --- Resources (for shop showcases) ---
  const insertedResources = await db
    .insert(resources)
    .values([
      { name: "薬草", itemId: insertedItems[0].id, recoverCount: 10, recoverInterval: 3600, maxCount: 99 },
      { name: "回復薬", itemId: insertedItems[1].id, recoverCount: 5, recoverInterval: 3600, maxCount: 99 },
      { name: "木の剣", itemId: insertedItems[2].id, recoverCount: 1, recoverInterval: 7200, maxCount: 10 },
      { name: "革の鎧", itemId: insertedItems[3].id, recoverCount: 1, recoverInterval: 7200, maxCount: 10 },
      { name: "鉄の剣", itemId: insertedItems[4].id, recoverCount: 1, recoverInterval: 14400, maxCount: 5 },
      { name: "鋼の盾", itemId: insertedItems[5].id, recoverCount: 1, recoverInterval: 14400, maxCount: 5 },
      { name: "革のヘルム", itemId: insertedItems[6].id, recoverCount: 1, recoverInterval: 7200, maxCount: 10 },
    ])
    .onConflictDoNothing()
    .returning();

  // --- Showcases (shop display items with prices) ---
  await db
    .insert(showcases)
    .values([
      { shopId: insertedShops[0].id, resourceId: insertedResources[0].id, cost: 10 },
      { shopId: insertedShops[0].id, resourceId: insertedResources[1].id, cost: 30 },
      { shopId: insertedShops[0].id, resourceId: insertedResources[2].id, cost: 50 },
      { shopId: insertedShops[0].id, resourceId: insertedResources[3].id, cost: 80 },
      { shopId: insertedShops[0].id, resourceId: insertedResources[6].id, cost: 60 },
      { shopId: insertedShops[1].id, resourceId: insertedResources[0].id, cost: 10 },
      { shopId: insertedShops[1].id, resourceId: insertedResources[1].id, cost: 30 },
      { shopId: insertedShops[1].id, resourceId: insertedResources[4].id, cost: 200 },
      { shopId: insertedShops[1].id, resourceId: insertedResources[5].id, cost: 150 },
    ])
    .onConflictDoNothing();
  console.log("  Inserted resources and showcases");

  // --- Establishments (link shops/inns to towns) ---
  await db
    .insert(establishments)
    .values([
      { townId: 1, establishmentType: 1, establishmentId: insertedShops[0].id }, // 始まりの町 → 武器屋
      { townId: 1, establishmentType: 2, establishmentId: 1 },                   // 始まりの町 → 宿屋
      { townId: 2, establishmentType: 1, establishmentId: insertedShops[1].id }, // 交易の町 → 道具屋
      { townId: 2, establishmentType: 2, establishmentId: 2 },                   // 交易の町 → 宿屋
    ])
    .onConflictDoNothing();
  console.log("  Inserted establishments");

  // --- Dungeons ---
  await db
    .insert(dungeons)
    .values([
      { name: "古代遺跡", description: "古の文明が眠る遺跡", maxFloor: 5, minSearch: 1, maxSearch: 3 },
      { name: "暗黒洞窟", description: "奥深い洞窟に強力な魔物が潜む", maxFloor: 10, minSearch: 2, maxSearch: 5 },
    ])
    .onConflictDoNothing();
  console.log("  Inserted dungeons");

  // --- Skills ---
  await db
    .insert(skills)
    .values([
      { name: "鍛冶", description: "金属の武器や防具を作る技術" },
      { name: "錬金術", description: "素材を調合してアイテムを作る技術" },
      { name: "採取", description: "自然から素材を集める技術" },
    ])
    .onConflictDoNothing();
  console.log("  Inserted skills");

  // --- Soldiers ---
  await db
    .insert(soldiers)
    .values([
      { name: "見習い戦士", description: "駆け出しの戦士", strMin: 4, strMax: 8, dexMin: 2, dexMax: 4, vitMin: 5, vitMax: 10, levelMax: 10 },
      { name: "森のレンジャー", description: "素早さが自慢の射手", strMin: 3, strMax: 6, dexMin: 5, dexMax: 10, vitMin: 3, vitMax: 7, levelMax: 15 },
      { name: "重装騎士", description: "鉄壁の守りを誇る騎士", strMin: 6, strMax: 12, dexMin: 1, dexMax: 3, vitMin: 8, vitMax: 15, levelMax: 20 },
    ])
    .onConflictDoNothing();
  console.log("  Inserted soldiers");

  // --- Quests ---
  const insertedQuests = await db
    .insert(quests)
    .values([
      { name: "初めての討伐", description: "スライムを3体倒そう" },
      { name: "ゴブリン退治", description: "ゴブリンを5体倒そう" },
      { name: "素材集め", description: "鉄鉱石を3つ集めよう" },
    ])
    .onConflictDoNothing()
    .returning();

  if (insertedQuests.length > 0) {
    await db
      .insert(questConditions)
      .values([
        { questId: insertedQuests[0].id, target: 1, conditionType: 1, conditionId: insertedEnemies[0].id, conditionValue: 3 },
        { questId: insertedQuests[1].id, target: 1, conditionType: 1, conditionId: insertedEnemies[1].id, conditionValue: 5 },
        { questId: insertedQuests[2].id, target: 2, conditionType: 2, conditionId: insertedItems[10].id, conditionValue: 3 },
      ])
      .onConflictDoNothing();
  }
  console.log("  Inserted quests");

  // --- Recipes ---
  await db
    .insert(recipes)
    .values([
      {
        requiredItemId1: insertedItems[10].id, requiredItemCount1: 3,  // 鉄鉱石 x3
        productItemId: insertedItems[4].id, productItemCount: 1,       // → 鉄の剣
        skillId: 1, difficulty: 1,
      },
      {
        requiredItemId1: insertedItems[7].id, requiredItemCount1: 5,   // スライムゼリー x5
        productItemId: insertedItems[0].id, productItemCount: 3,       // → 薬草 x3
        skillId: 2, difficulty: 1,
      },
    ])
    .onConflictDoNothing();
  console.log("  Inserted recipes");

  console.log("Seed complete!");
  process.exit(0);
}

seed().catch((err) => {
  console.error("Seed failed:", err);
  process.exit(1);
});
