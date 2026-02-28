"use client";

import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";

export default function InnPage() {
  const { data: player, refetch: refetchPlayer } = trpc.player.me.useQuery();
  const { data: inn } = trpc.inn.get.useQuery({ innId: 1 });
  const sleepMutation = trpc.inn.sleep.useMutation({
    onSuccess: () => refetchPlayer(),
  });

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">🏨 宿屋</h1>

        {!inn && (
          <div className="rpg-frame p-6 text-center text-muted-foreground">
            宿屋が見つかりません
          </div>
        )}

        {inn && (
          <div className="rpg-frame-gold p-6 space-y-4">
            <h2 className="font-heading text-xl">{inn.name}</h2>
            {inn.description && (
              <p className="text-sm text-muted-foreground">{inn.description}</p>
            )}
            <div className="flex justify-between items-center">
              <span className="text-muted-foreground">宿泊料</span>
              <span className="text-gold font-bold">{inn.rails} Rails</span>
            </div>
            <button
              onClick={() => sleepMutation.mutate({ innId: inn.id })}
              disabled={sleepMutation.isPending || (player?.hp === player?.hpMax)}
              className="w-full py-3 rounded bg-primary text-primary-foreground font-bold hover:bg-primary/90 disabled:opacity-50"
            >
              {player?.hp === player?.hpMax ? "HPは満タンです" : "休む (HP全回復)"}
            </button>
          </div>
        )}
      </div>

      <div>{player && <StatusPanel player={player} />}</div>
    </div>
  );
}
