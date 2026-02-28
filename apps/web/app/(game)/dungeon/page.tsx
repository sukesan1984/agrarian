"use client";

import { trpc } from "@/lib/trpc";
import Link from "next/link";

export default function DungeonPage() {
  const { data: status, isLoading, refetch } = trpc.dungeon.status.useQuery();
  const searchMutation = trpc.dungeon.search.useMutation({
    onSuccess: () => refetch(),
  });
  const ascendMutation = trpc.dungeon.ascend.useMutation({
    onSuccess: () => refetch(),
  });
  const escapeMutation = trpc.dungeon.escape.useMutation({
    onSuccess: () => refetch(),
  });

  if (isLoading) {
    return <div className="text-muted-foreground py-12 text-center">読み込み中...</div>;
  }

  if (!status) {
    return (
      <div className="space-y-6">
        <h1 className="font-heading text-3xl text-primary">🏰 ダンジョン</h1>
        <div className="rpg-frame p-6 text-center text-muted-foreground">
          現在ダンジョンに入っていません。エリア画面からダンジョンに入れます。
        </div>
        <Link
          href="/area"
          className="block w-full max-w-xs mx-auto py-3 rounded bg-primary text-primary-foreground font-bold text-center hover:bg-primary/90"
        >
          エリアに戻る
        </Link>
      </div>
    );
  }

  return (
    <div className="space-y-6 max-w-2xl mx-auto">
      <h1 className="font-heading text-3xl text-primary">🏰 {status.dungeon.name}</h1>

      <div className="rpg-frame-gold p-6 space-y-4">
        <div className="grid grid-cols-2 gap-4 text-sm">
          <div>
            <span className="text-muted-foreground">現在の階層</span>
            <div className="text-2xl font-bold text-primary">{status.userDungeon.currentFloor}F</div>
          </div>
          <div>
            <span className="text-muted-foreground">探索回数</span>
            <div className="text-2xl font-bold">{status.userDungeon.searchCount}</div>
          </div>
        </div>

        {status.userDungeon.foundFootstep && (
          <div className="p-3 rounded bg-primary/10 border border-primary/30 text-primary text-sm font-bold">
            階段を発見しています！
          </div>
        )}
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
        <button
          onClick={() => searchMutation.mutate()}
          disabled={searchMutation.isPending}
          className="py-3 rounded bg-primary text-primary-foreground font-bold hover:bg-primary/90 disabled:opacity-50"
        >
          探索する
        </button>
        <button
          onClick={() => ascendMutation.mutate()}
          disabled={ascendMutation.isPending || !status.userDungeon.foundFootstep}
          className="py-3 rounded bg-secondary text-foreground font-bold hover:bg-secondary/80 disabled:opacity-50"
        >
          階段を降りる
        </button>
        <button
          onClick={() => escapeMutation.mutate()}
          disabled={escapeMutation.isPending}
          className="py-3 rounded bg-destructive text-destructive-foreground font-bold hover:bg-destructive/90 disabled:opacity-50"
        >
          脱出する
        </button>
      </div>
    </div>
  );
}
