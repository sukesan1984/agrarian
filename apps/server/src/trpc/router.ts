import { router } from "./trpc";
import { playerRouter } from "./routers/player";
import { areaRouter } from "./routers/area";
import { battleRouter } from "./routers/battle";
import { itemRouter } from "./routers/item";
import { equipmentRouter } from "./routers/equipment";
import { shopRouter } from "./routers/shop";
import { questRouter } from "./routers/quest";
import { dungeonRouter } from "./routers/dungeon";
import { recipeRouter } from "./routers/recipe";
import { skillRouter } from "./routers/skill";
import { soldierRouter } from "./routers/soldier";
import { bankRouter } from "./routers/bank";
import { innRouter } from "./routers/inn";
import { natureFieldRouter } from "./routers/nature-field";
import { chatRouter } from "./routers/chat";
import { rankingRouter } from "./routers/ranking";

export const appRouter = router({
  player: playerRouter,
  area: areaRouter,
  battle: battleRouter,
  item: itemRouter,
  equipment: equipmentRouter,
  shop: shopRouter,
  quest: questRouter,
  dungeon: dungeonRouter,
  recipe: recipeRouter,
  skill: skillRouter,
  soldier: soldierRouter,
  bank: bankRouter,
  inn: innRouter,
  natureField: natureFieldRouter,
  chat: chatRouter,
  ranking: rankingRouter,
});

export type AppRouter = typeof appRouter;
