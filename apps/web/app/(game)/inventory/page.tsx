"use client";

import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";

export default function InventoryPage() {
  const { data: player } = trpc.player.me.useQuery();
  const { data: inventory, isLoading, refetch } = trpc.item.inventory.useQuery();
  const useMutation = trpc.item.use.useMutation({ onSuccess: () => refetch() });
  const sellMutation = trpc.item.sell.useMutation({ onSuccess: () => refetch() });
  const throwMutation = trpc.item.throw.useMutation({ onSuccess: () => refetch() });

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">🎒 アイテム</h1>

        {isLoading && <div className="text-muted-foreground">読み込み中...</div>}

        {inventory && inventory.length === 0 && (
          <div className="rpg-frame p-6 text-center text-muted-foreground">
            アイテムを持っていません
          </div>
        )}

        <div className="space-y-3">
          {inventory?.map(({ userItem, item }) => (
            <div key={userItem.id} className="rpg-frame p-4 flex items-center justify-between">
              <div>
                <div className="font-bold">{item.name}</div>
                <div className="text-xs text-muted-foreground">
                  {item.description}
                </div>
                <div className="text-xs text-muted-foreground mt-1">
                  所持数: {userItem.count}
                  {item.sellPrice ? ` | 売値: ${item.sellPrice} Rails` : ""}
                </div>
              </div>
              <div className="flex gap-2">
                <button
                  onClick={() => useMutation.mutate({ userItemId: userItem.id })}
                  disabled={useMutation.isPending}
                  className="px-3 py-1.5 text-xs rounded bg-hp text-white hover:bg-hp/80 disabled:opacity-50"
                >
                  使う
                </button>
                {item.sellPrice && (
                  <button
                    onClick={() => sellMutation.mutate({ userItemId: userItem.id, count: 1 })}
                    disabled={sellMutation.isPending}
                    className="px-3 py-1.5 text-xs rounded bg-gold text-primary-foreground hover:bg-gold/80 disabled:opacity-50"
                  >
                    売る
                  </button>
                )}
                <button
                  onClick={() => throwMutation.mutate({ userItemId: userItem.id, count: 1 })}
                  disabled={throwMutation.isPending}
                  className="px-3 py-1.5 text-xs rounded bg-secondary text-foreground hover:bg-secondary/80 disabled:opacity-50"
                >
                  捨てる
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div>{player && <StatusPanel player={player} />}</div>
    </div>
  );
}
