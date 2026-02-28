"use client";

import { useState } from "react";
import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";
import { BattleLog } from "@/components/game/battle-log";
import { HpGauge } from "@/components/game/hp-gauge";
import Link from "next/link";

export default function BattlePage() {
  const { data: player, refetch: refetchPlayer } = trpc.player.me.useQuery();
  const { data: battleStatus, refetch: refetchBattle } = trpc.battle.status.useQuery();
  const [log, setLog] = useState<string[]>([]);
  const [battleResult, setBattleResult] = useState<{
    victory: boolean;
    rewards: { exp: number; rails: number; levelUp: number | null } | null;
  } | null>(null);

  const encounterMutation = trpc.battle.encounter.useMutation({
    onSuccess: (data) => {
      if (data.encountered) {
        setLog(["敵が現れた！"]);
        setBattleResult(null);
        refetchBattle();
      } else {
        setLog(["敵は現れなかった..."]);
      }
    },
  });

  const attackMutation = trpc.battle.attack.useMutation({
    onSuccess: (data) => {
      setLog((prev) => [...prev, ...data.log]);
      if (data.battleEnd) {
        setBattleResult({ victory: data.victory, rewards: data.rewards });
        refetchBattle();
      }
      refetchPlayer();
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
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">バトル</h1>

        {!inBattle && !battleResult && (
          <div className="rpg-frame p-6 space-y-4">
            <p className="text-muted-foreground">
              探索して敵を見つけましょう
            </p>
            <button
              onClick={() => encounterMutation.mutate()}
              disabled={encounterMutation.isPending}
              className="w-full py-3 rounded bg-destructive text-destructive-foreground font-bold hover:bg-destructive/90 disabled:opacity-50"
            >
              {encounterMutation.isPending ? "探索中..." : "探索する"}
            </button>
          </div>
        )}

        {inBattle && battleStatus && (
          <div className="rpg-frame p-6 space-y-4">
            <h2 className="font-heading text-lg text-destructive">⚔️ 戦闘中</h2>
            <div className="space-y-3">
              {battleStatus.enemies.map((e) => (
                <div key={e.id} className="rpg-frame p-3 space-y-2">
                  <div className="flex justify-between items-center">
                    <span className="font-bold">{e.enemy.name}</span>
                    <span className="text-xs text-muted-foreground">
                      Lv.{e.enemy.level}
                    </span>
                  </div>
                  <HpGauge current={e.currentHp} max={e.enemy.hp} />
                </div>
              ))}
            </div>

            <div className="flex gap-3">
              <button
                onClick={() => attackMutation.mutate()}
                disabled={attackMutation.isPending}
                className="flex-1 py-3 rounded bg-destructive text-destructive-foreground font-bold hover:bg-destructive/90 disabled:opacity-50"
              >
                攻撃
              </button>
              <button
                onClick={() => escapeMutation.mutate()}
                disabled={escapeMutation.isPending}
                className="flex-1 py-3 rounded bg-secondary text-foreground font-bold hover:bg-secondary/80 disabled:opacity-50"
              >
                逃走
              </button>
            </div>
          </div>
        )}

        {battleResult && (
          <div className="rpg-frame-gold p-6 space-y-4">
            <h2 className="font-heading text-lg text-primary">
              {battleResult.victory ? "🎉 勝利！" : "💀 敗北..."}
            </h2>
            {battleResult.rewards && (
              <div className="space-y-2 text-sm">
                <div className="flex justify-between">
                  <span>獲得EXP</span>
                  <span className="text-exp font-bold">+{battleResult.rewards.exp}</span>
                </div>
                <div className="flex justify-between">
                  <span>獲得Rails</span>
                  <span className="text-gold font-bold">+{battleResult.rewards.rails}</span>
                </div>
                {battleResult.rewards.levelUp && (
                  <div className="text-primary font-bold text-center text-lg mt-2">
                    🎊 レベルアップ！ → Lv.{battleResult.rewards.levelUp}
                  </div>
                )}
              </div>
            )}
            <Link
              href="/area"
              className="block w-full py-3 rounded bg-primary text-primary-foreground font-bold text-center hover:bg-primary/90"
            >
              エリアに戻る
            </Link>
          </div>
        )}

        <BattleLog messages={log} />
      </div>

      <div>{player && <StatusPanel player={player} />}</div>
    </div>
  );
}
