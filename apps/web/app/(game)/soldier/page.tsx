"use client";

import { trpc } from "@/lib/trpc";
import { HpGauge } from "@/components/game/hp-gauge";

export default function SoldierPage() {
  const { data: soldiers, isLoading, refetch } = trpc.soldier.list.useQuery();
  const addMutation = trpc.soldier.addToParty.useMutation({ onSuccess: () => refetch() });
  const removeMutation = trpc.soldier.removeFromParty.useMutation({ onSuccess: () => refetch() });

  return (
    <div className="space-y-6">
      <h1 className="font-heading text-3xl text-primary">🛡️ 傭兵</h1>

      {isLoading && <div className="text-muted-foreground">読み込み中...</div>}

      {soldiers && soldiers.length === 0 && (
        <div className="rpg-frame p-6 text-center text-muted-foreground">
          傭兵を雇っていません
        </div>
      )}

      <div className="space-y-3">
        {soldiers?.map(({ userSoldier, soldier }) => (
          <div key={userSoldier.id} className="rpg-frame p-4 space-y-3">
            <div className="flex justify-between items-center">
              <div>
                <div className="font-bold">{soldier.name}</div>
                <div className="text-xs text-muted-foreground">{soldier.description}</div>
              </div>
              <span className={userSoldier.isInParty ? "text-hp text-xs font-bold" : "text-muted-foreground text-xs"}>
                {userSoldier.isInParty ? "パーティ中" : "待機中"}
              </span>
            </div>
            <HpGauge
              current={userSoldier.currentHp}
              max={soldier.vitMax * 4 + 50}
            />
            <button
              onClick={() =>
                userSoldier.isInParty
                  ? removeMutation.mutate({ userSoldierId: userSoldier.id })
                  : addMutation.mutate({ userSoldierId: userSoldier.id })
              }
              className="w-full py-2 rounded bg-secondary text-foreground text-sm font-bold hover:bg-secondary/80"
            >
              {userSoldier.isInParty ? "パーティから外す" : "パーティに加える"}
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}
