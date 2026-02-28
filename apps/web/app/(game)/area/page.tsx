"use client";

import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";
import Link from "next/link";

export default function AreaPage() {
  const { data: player } = trpc.player.me.useQuery();
  const { data: area, isLoading, refetch } = trpc.area.current.useQuery();
  const moveMutation = trpc.area.move.useMutation({
    onSuccess: () => refetch(),
  });

  if (isLoading) {
    return <div className="text-center text-muted-foreground py-12">読み込み中...</div>;
  }

  if (!area) {
    return <div className="text-center text-muted-foreground py-12">エリア情報がありません</div>;
  }

  const areaName =
    area.areaDetail?.type === "town"
      ? area.areaDetail.data?.name
      : area.areaDetail?.type === "road"
        ? area.areaDetail.data?.name
        : `エリア ${area.area?.id}`;

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">{areaName}</h1>

        {area.areaDetail?.type === "town" && (
          <div className="rpg-frame p-6 space-y-4">
            <h2 className="font-heading text-lg text-primary">🏘️ 町の施設</h2>
            <div className="grid grid-cols-2 gap-3">
              <Link href="/shop" className="rpg-frame p-3 text-sm text-center hover:border-primary transition-colors">
                ショップ
              </Link>
              <Link href="/inn" className="rpg-frame p-3 text-sm text-center hover:border-primary transition-colors">
                宿屋
              </Link>
              <Link href="/bank" className="rpg-frame p-3 text-sm text-center hover:border-primary transition-colors">
                銀行
              </Link>
            </div>
          </div>
        )}

        {area.areaDetail?.type === "road" && area.area?.enemyRate && (
          <div className="rpg-frame p-6 space-y-4">
            <h2 className="font-heading text-lg text-primary">⚠️ 敵出現エリア</h2>
            <p className="text-sm text-muted-foreground">
              この道では敵が出現します (出現率: {area.area.enemyRate}%)
            </p>
            <Link
              href="/battle"
              className="block w-full py-3 rounded bg-destructive text-destructive-foreground font-bold text-center hover:bg-destructive/90 transition-colors"
            >
              探索する
            </Link>
          </div>
        )}

        {area.droppedItems.length > 0 && (
          <div className="rpg-frame p-6 space-y-4">
            <h2 className="font-heading text-lg text-primary">落ちているアイテム</h2>
            {area.droppedItems.map((di) => (
              <div key={di.thrownItem.id} className="flex items-center justify-between py-2 border-b border-border last:border-0">
                <span>{di.item.name} x{di.thrownItem.count}</span>
              </div>
            ))}
          </div>
        )}

        <div className="rpg-frame p-6 space-y-4">
          <h2 className="font-heading text-lg text-primary">移動先</h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {area.connectedNodes.map((cn) => {
              if (!cn) return null;
              return (
                <button
                  key={cn.node.id}
                  onClick={() => moveMutation.mutate({ targetAreaNodeId: cn.node.id })}
                  disabled={moveMutation.isPending}
                  className="rpg-frame p-4 text-left hover:border-primary transition-colors disabled:opacity-50"
                >
                  <div className="text-sm font-bold">Node #{cn.node.id}</div>
                  <div className="text-xs text-muted-foreground">
                    エリアタイプ: {cn.area?.areaType === 1 ? "町" : cn.area?.areaType === 2 ? "道" : "その他"}
                  </div>
                </button>
              );
            })}
          </div>
        </div>
      </div>

      <div>{player && <StatusPanel player={player} />}</div>
    </div>
  );
}
