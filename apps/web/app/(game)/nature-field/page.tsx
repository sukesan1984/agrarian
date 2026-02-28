"use client";

import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";

export default function NatureFieldPage() {
  const { data: player, refetch: refetchPlayer } = trpc.player.me.useQuery();
  const { data: field, refetch: refetchField } = trpc.natureField.get.useQuery({ fieldId: 1 });
  const harvestMutation = trpc.natureField.harvest.useMutation({
    onSuccess: () => { refetchPlayer(); refetchField(); },
  });

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">🌿 自然フィールド</h1>

        {!field && (
          <div className="rpg-frame p-6 text-center text-muted-foreground">
            フィールドが見つかりません
          </div>
        )}

        {field && (
          <div className="rpg-frame p-6 space-y-4">
            <h2 className="font-heading text-lg">{field.field.name}</h2>
            {field.field.description && (
              <p className="text-sm text-muted-foreground">{field.field.description}</p>
            )}
            {field.resource && (
              <div className="text-xs text-muted-foreground">
                資源: {field.resource.name}
              </div>
            )}
            <button
              onClick={() => harvestMutation.mutate({ fieldId: field.field.id })}
              disabled={harvestMutation.isPending}
              className="w-full py-3 rounded bg-hp text-white font-bold hover:bg-hp/80 disabled:opacity-50"
            >
              {harvestMutation.isPending ? "採集中..." : "採集する"}
            </button>
          </div>
        )}
      </div>

      <div>{player && <StatusPanel player={player} />}</div>
    </div>
  );
}
