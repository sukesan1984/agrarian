"use client";

import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";

export default function ShopPage() {
  const { data: player, refetch: refetchPlayer } = trpc.player.me.useQuery();
  const { data: shop } = trpc.shop.get.useQuery({ shopId: 1 });
  const buyMutation = trpc.shop.buy.useMutation({
    onSuccess: () => refetchPlayer(),
  });

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">🏪 ショップ</h1>

        {!shop && (
          <div className="rpg-frame p-6 text-center text-muted-foreground">
            ショップが見つかりません
          </div>
        )}

        {shop && (
          <div className="rpg-frame p-6 space-y-4">
            <h2 className="font-heading text-lg">{shop.shop.name}</h2>
            {shop.shop.description && (
              <p className="text-sm text-muted-foreground">{shop.shop.description}</p>
            )}

            <div className="space-y-3">
              {shop.showcases.map((sc) => (
                <div key={sc.showcase.id} className="rpg-frame p-4 flex items-center justify-between">
                  <div>
                    <div className="font-bold">{sc.item?.name ?? `Resource #${sc.resource.id}`}</div>
                    <div className="text-xs text-muted-foreground">
                      {sc.item?.description}
                    </div>
                  </div>
                  <div className="flex items-center gap-3">
                    <span className="text-gold text-sm font-bold">{sc.showcase.cost} Rails</span>
                    <button
                      onClick={() => buyMutation.mutate({ showcaseId: sc.showcase.id, count: 1 })}
                      disabled={buyMutation.isPending}
                      className="px-3 py-1.5 text-xs rounded bg-primary text-primary-foreground hover:bg-primary/80 disabled:opacity-50"
                    >
                      購入
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>

      <div>{player && <StatusPanel player={player} />}</div>
    </div>
  );
}
