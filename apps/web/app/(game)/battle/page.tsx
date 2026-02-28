"use client";

import { useState, useCallback, useRef, useEffect } from "react";
import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";
import { BattleLog } from "@/components/game/battle-log";
import { HpGauge } from "@/components/game/hp-gauge";
import Link from "next/link";

interface EnemyState {
  id: number;
  enemy: { name: string; level: number; hp: number };
  currentHp: number;
  shaking: boolean;
  defeated: boolean;
  damagePopup: { value: number; key: number } | null;
}

interface BattleRewards {
  exp: number;
  rails: number;
  levelUp: number | null;
  drops?: { itemName: string; count: number }[];
}

export default function BattlePage() {
  const { data: player, refetch: refetchPlayer } = trpc.player.me.useQuery();
  const { data: battleStatus, refetch: refetchBattle } =
    trpc.battle.status.useQuery();
  const [log, setLog] = useState<string[]>([]);
  const [battleResult, setBattleResult] = useState<{
    victory: boolean;
    rewards: BattleRewards | null;
  } | null>(null);
  const [enemyStates, setEnemyStates] = useState<EnemyState[]>([]);
  const [showScreenFlash, setShowScreenFlash] = useState(false);
  const [isAnimating, setIsAnimating] = useState(false);
  const [showVictory, setShowVictory] = useState(false);
  const popupKeyRef = useRef(0);

  useEffect(() => {
    if (battleStatus?.enemies) {
      setEnemyStates((prev) => {
        if (prev.length > 0) return prev;
        return battleStatus.enemies.map((e) => ({
          id: e.id,
          enemy: e.enemy,
          currentHp: e.currentHp,
          shaking: false,
          defeated: false,
          damagePopup: null,
        }));
      });
    }
  }, [battleStatus]);

  const animateEvents = useCallback(
    async (events: any[], newLog: string[]) => {
      setIsAnimating(true);

      for (const event of events) {
        if (event.type === "playerAttack") {
          popupKeyRef.current++;
          const pKey = popupKeyRef.current;

          setEnemyStates((prev) =>
            prev.map((es) =>
              es.id === event.targetId
                ? {
                    ...es,
                    shaking: true,
                    currentHp: event.enemyHp,
                    damagePopup: { value: event.damage, key: pKey },
                  }
                : es
            )
          );

          await sleep(400);

          setEnemyStates((prev) =>
            prev.map((es) =>
              es.id === event.targetId
                ? {
                    ...es,
                    shaking: false,
                    damagePopup: null,
                    defeated: event.killed ? true : es.defeated,
                  }
                : es
            )
          );

          if (event.killed) {
            await sleep(600);
          } else {
            await sleep(150);
          }
        } else if (event.type === "enemyAttack") {
          setShowScreenFlash(true);
          await sleep(300);
          setShowScreenFlash(false);
          await sleep(150);
        } else if (event.type === "playerDefeated") {
          await sleep(400);
        } else if (event.type === "victory") {
          await sleep(300);
          setShowVictory(true);
        }
      }

      setLog((prev) => [...prev, ...newLog]);
      setIsAnimating(false);
    },
    []
  );

  const encounterMutation = trpc.battle.encounter.useMutation({
    onSuccess: (data) => {
      if (data.encountered) {
        setLog(["敵が現れた！"]);
        setBattleResult(null);
        setShowVictory(false);
        setEnemyStates([]);
        refetchBattle();
      } else {
        setLog(["敵は現れなかった..."]);
      }
    },
  });

  const attackMutation = trpc.battle.attack.useMutation({
    onSuccess: (data) => {
      if (data.battleEnd) {
        setBattleResult({ victory: data.victory, rewards: data.rewards });
        refetchBattle();
      }
      refetchPlayer();

      if (data.events && data.events.length > 0) {
        animateEvents(data.events, data.log);
      } else {
        setLog((prev) => [...prev, ...data.log]);
      }
    },
  });

  const escapeMutation = trpc.battle.escape.useMutation({
    onSuccess: (data) => {
      if (data.escaped) {
        setLog((prev) => [...prev, "逃走に成功した！"]);
        refetchBattle();
      } else {
        setLog((prev) => [...prev, "逃走に失敗した..."]);
      }
    },
  });

  const inBattle = !!battleStatus;

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 relative">
      {showScreenFlash && (
        <div className="fixed inset-0 bg-destructive z-50 pointer-events-none animate-screen-flash" />
      )}

      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">バトル</h1>

        {!inBattle && !battleResult && (
          <div className="rpg-frame p-6 space-y-4">
            <p className="text-muted-foreground">探索して敵を見つけましょう</p>
            <button
              onClick={() => encounterMutation.mutate()}
              disabled={encounterMutation.isPending}
              className="w-full py-3 rounded bg-destructive text-destructive-foreground font-bold hover:bg-destructive/90 disabled:opacity-50 transition-colors"
            >
              {encounterMutation.isPending ? "探索中..." : "探索する"}
            </button>
          </div>
        )}

        {inBattle && battleStatus && !battleResult && (
          <div className="rpg-frame p-6 space-y-4">
            <h2 className="font-heading text-lg text-destructive">
              戦闘中
            </h2>

            <div className="space-y-3">
              {enemyStates.map((es) => (
                <div
                  key={es.id}
                  className={`rpg-frame p-4 relative overflow-hidden transition-all ${
                    es.shaking ? "animate-battle-shake" : ""
                  } ${es.defeated ? "animate-enemy-defeat" : ""}`}
                >
                  <div className="flex justify-between items-center mb-2">
                    <div className="flex items-center gap-2">
                      <span className="text-lg">
                        {getEnemyEmoji(es.enemy.name)}
                      </span>
                      <span className="font-bold">{es.enemy.name}</span>
                    </div>
                    <span className="text-xs text-muted-foreground">
                      Lv.{es.enemy.level}
                    </span>
                  </div>
                  <HpGauge current={es.currentHp} max={es.enemy.hp} />

                  {es.damagePopup && (
                    <div
                      key={es.damagePopup.key}
                      className="absolute top-2 right-4 text-2xl font-bold text-destructive animate-damage-pop pointer-events-none"
                    >
                      -{es.damagePopup.value}
                    </div>
                  )}
                </div>
              ))}
            </div>

            <div className="flex gap-3">
              <button
                onClick={() => attackMutation.mutate()}
                disabled={attackMutation.isPending || isAnimating}
                className="flex-1 py-3 rounded bg-destructive text-destructive-foreground font-bold hover:bg-destructive/90 disabled:opacity-50 transition-colors"
              >
                {isAnimating ? "攻撃中..." : "攻撃"}
              </button>
              <button
                onClick={() => escapeMutation.mutate()}
                disabled={
                  escapeMutation.isPending ||
                  isAnimating ||
                  attackMutation.isPending
                }
                className="flex-1 py-3 rounded bg-secondary text-foreground font-bold hover:bg-secondary/80 disabled:opacity-50 transition-colors"
              >
                逃走
              </button>
            </div>
          </div>
        )}

        {battleResult && (
          <div
            className={`rpg-frame-gold p-6 space-y-4 ${showVictory ? "animate-victory-glow" : ""}`}
          >
            <h2 className="font-heading text-lg text-primary">
              {battleResult.victory ? "勝利！" : "敗北..."}
            </h2>

            {battleResult.rewards && (
              <div className="space-y-3">
                <div className="flex justify-between items-center animate-slide-up">
                  <span className="text-sm">獲得EXP</span>
                  <span className="text-exp font-bold text-lg">
                    +{battleResult.rewards.exp}
                  </span>
                </div>
                <div
                  className="flex justify-between items-center animate-slide-up"
                  style={{ animationDelay: "0.1s" }}
                >
                  <span className="text-sm">獲得Rails</span>
                  <span className="text-gold font-bold text-lg">
                    +{battleResult.rewards.rails}
                  </span>
                </div>

                {battleResult.rewards.levelUp && (
                  <div
                    className="text-primary font-bold text-center text-xl mt-2 animate-slide-up"
                    style={{ animationDelay: "0.2s" }}
                  >
                    レベルアップ！ Lv.{battleResult.rewards.levelUp}
                  </div>
                )}

                {battleResult.rewards.drops &&
                  battleResult.rewards.drops.length > 0 && (
                    <div
                      className="mt-4 pt-3 border-t border-border animate-slide-up"
                      style={{ animationDelay: "0.3s" }}
                    >
                      <h3 className="text-sm font-bold text-primary mb-2">
                        ドロップアイテム
                      </h3>
                      <div className="space-y-1">
                        {battleResult.rewards.drops.map((drop, i) => (
                          <div
                            key={i}
                            className="flex justify-between items-center text-sm"
                          >
                            <span>{drop.itemName}</span>
                            <span className="text-primary font-bold">
                              x{drop.count}
                            </span>
                          </div>
                        ))}
                      </div>
                    </div>
                  )}
              </div>
            )}

            <div className="flex gap-3 mt-4">
              <Link
                href="/area"
                className="flex-1 py-3 rounded bg-primary text-primary-foreground font-bold text-center hover:bg-primary/90 transition-colors"
              >
                エリアに戻る
              </Link>
              <button
                onClick={() => {
                  setBattleResult(null);
                  setShowVictory(false);
                  setEnemyStates([]);
                  encounterMutation.mutate();
                }}
                disabled={encounterMutation.isPending}
                className="flex-1 py-3 rounded bg-destructive text-destructive-foreground font-bold hover:bg-destructive/90 disabled:opacity-50 transition-colors"
              >
                続けて探索
              </button>
            </div>
          </div>
        )}

        <BattleLog messages={log} />
      </div>

      <div>{player && <StatusPanel player={player} />}</div>
    </div>
  );
}

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function getEnemyEmoji(name: string): string {
  const map: Record<string, string> = {
    スライム: "🟢",
    ゴブリン: "👺",
    オオカミ: "🐺",
    オーク: "👹",
    トロール: "🧌",
  };
  return map[name] ?? "👾";
}
