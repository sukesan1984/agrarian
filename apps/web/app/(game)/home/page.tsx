"use client";

import { useState } from "react";
import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";
import Link from "next/link";

export default function HomePage() {
  const { data: player, isLoading, refetch } = trpc.player.me.useQuery();
  const createPlayer = trpc.player.create.useMutation({
    onSuccess: () => refetch(),
  });
  const [playerName, setPlayerName] = useState("");

  if (isLoading) {
    return <div className="text-center text-muted-foreground py-12">読み込み中...</div>;
  }

  if (!player) {
    return (
      <div className="max-w-md mx-auto py-12">
        <div className="rpg-frame-gold p-8 space-y-6">
          <h1 className="font-heading text-2xl text-primary text-center">
            冒険者登録
          </h1>
          <p className="text-muted-foreground text-sm text-center">
            キャラクター名を入力して冒険を始めましょう
          </p>
          <input
            type="text"
            value={playerName}
            onChange={(e) => setPlayerName(e.target.value)}
            placeholder="キャラクター名"
            maxLength={20}
            className="w-full px-4 py-2 rounded bg-secondary border border-border text-foreground focus:border-primary focus:outline-none"
          />
          <button
            onClick={() => createPlayer.mutate({ name: playerName })}
            disabled={!playerName || createPlayer.isPending}
            className="w-full py-3 rounded bg-primary text-primary-foreground font-bold hover:bg-primary/90 disabled:opacity-50"
          >
            {createPlayer.isPending ? "作成中..." : "キャラクター作成"}
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">マイページ</h1>

        <div className="rpg-frame p-6">
          <h2 className="font-heading text-lg text-primary mb-4">冒険メニュー</h2>
          <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
            <MenuLink href="/area" label="エリア移動" icon="🗺️" />
            <MenuLink href="/inventory" label="アイテム" icon="🎒" />
            <MenuLink href="/equipment" label="装備" icon="⚔️" />
            <MenuLink href="/character" label="ステータス" icon="📊" />
            <MenuLink href="/quest" label="クエスト" icon="📜" />
            <MenuLink href="/recipe" label="レシピ" icon="🔨" />
            <MenuLink href="/skill" label="スキル" icon="✨" />
            <MenuLink href="/soldier" label="傭兵" icon="🛡️" />
            <MenuLink href="/bank" label="銀行" icon="🏦" />
            <MenuLink href="/ranking" label="ランキング" icon="🏆" />
            <MenuLink href="/chat" label="チャット" icon="💬" />
          </div>
        </div>
      </div>

      <div>
        <StatusPanel player={player} />
      </div>
    </div>
  );
}

function MenuLink({ href, label, icon }: { href: string; label: string; icon: string }) {
  return (
    <Link
      href={href}
      className="rpg-frame p-4 text-center hover:border-primary transition-colors group"
    >
      <div className="text-2xl mb-1">{icon}</div>
      <div className="text-sm text-muted-foreground group-hover:text-primary transition-colors">
        {label}
      </div>
    </Link>
  );
}
