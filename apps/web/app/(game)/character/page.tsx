"use client";

import { trpc } from "@/lib/trpc";
import { HpGauge } from "@/components/game/hp-gauge";

export default function CharacterPage() {
  const { data: player, isLoading, refetch } = trpc.player.me.useQuery();
  const increaseMutation = trpc.player.increaseStats.useMutation({
    onSuccess: () => refetch(),
  });

  if (isLoading || !player) {
    return <div className="text-muted-foreground py-12 text-center">読み込み中...</div>;
  }

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      <h1 className="font-heading text-3xl text-primary">📊 ステータス</h1>

      <div className="rpg-frame-gold p-6 space-y-6">
        <h2 className="font-heading text-2xl text-center">{player.name}</h2>

        <HpGauge current={player.hp} max={player.hpMax} />

        <div className="flex justify-between items-center">
          <span className="text-muted-foreground">所持金</span>
          <span className="text-gold font-bold">{player.rails.toLocaleString()} Rails</span>
        </div>

        <div className="flex justify-between items-center">
          <span className="text-muted-foreground">経験値</span>
          <span className="text-exp font-bold">{player.exp.toLocaleString()}</span>
        </div>

        {player.remainingPoints > 0 && (
          <div className="p-3 rounded bg-primary/10 border border-primary/30 text-primary text-sm text-center font-bold">
            未割当ポイント: {player.remainingPoints}
          </div>
        )}

        <div className="space-y-3">
          <StatRow
            label="STR (攻撃力)"
            value={player.str}
            canIncrease={player.remainingPoints > 0}
            onIncrease={() => increaseMutation.mutate({ stat: "str", amount: 1 })}
            isPending={increaseMutation.isPending}
          />
          <StatRow
            label="DEX (器用さ)"
            value={player.dex}
            canIncrease={player.remainingPoints > 0}
            onIncrease={() => increaseMutation.mutate({ stat: "dex", amount: 1 })}
            isPending={increaseMutation.isPending}
          />
          <StatRow
            label="VIT (体力)"
            value={player.vit}
            canIncrease={player.remainingPoints > 0}
            onIncrease={() => increaseMutation.mutate({ stat: "vit", amount: 1 })}
            isPending={increaseMutation.isPending}
          />
          <StatRow
            label="ENE (エネルギー)"
            value={player.ene}
            canIncrease={player.remainingPoints > 0}
            onIncrease={() => increaseMutation.mutate({ stat: "ene", amount: 1 })}
            isPending={increaseMutation.isPending}
          />
        </div>
      </div>
    </div>
  );
}

function StatRow({
  label,
  value,
  canIncrease,
  onIncrease,
  isPending,
}: {
  label: string;
  value: number;
  canIncrease: boolean;
  onIncrease: () => void;
  isPending: boolean;
}) {
  return (
    <div className="flex items-center justify-between py-2 px-3 rounded bg-secondary/50">
      <span className="text-sm">{label}</span>
      <div className="flex items-center gap-3">
        <span className="font-mono font-bold text-lg">{value}</span>
        {canIncrease && (
          <button
            onClick={onIncrease}
            disabled={isPending}
            className="w-8 h-8 rounded bg-primary text-primary-foreground font-bold text-lg flex items-center justify-center hover:bg-primary/80 disabled:opacity-50"
          >
            +
          </button>
        )}
      </div>
    </div>
  );
}
