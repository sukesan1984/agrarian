"use client";

import { useState } from "react";
import { trpc } from "@/lib/trpc";

export default function RankingPage() {
  const [tab, setTab] = useState<"rails" | "exp">("rails");
  const { data: railsRanking } = trpc.ranking.byRails.useQuery();
  const { data: expRanking } = trpc.ranking.byExp.useQuery();

  const ranking = tab === "rails" ? railsRanking : expRanking;

  return (
    <div className="space-y-6 max-w-2xl mx-auto">
      <h1 className="font-heading text-3xl text-primary">🏆 ランキング</h1>

      <div className="flex gap-3">
        <button
          onClick={() => setTab("rails")}
          className={`px-4 py-2 rounded text-sm font-bold transition-colors ${
            tab === "rails"
              ? "bg-primary text-primary-foreground"
              : "bg-secondary text-muted-foreground hover:text-foreground"
          }`}
        >
          💰 所持金ランキング
        </button>
        <button
          onClick={() => setTab("exp")}
          className={`px-4 py-2 rounded text-sm font-bold transition-colors ${
            tab === "exp"
              ? "bg-primary text-primary-foreground"
              : "bg-secondary text-muted-foreground hover:text-foreground"
          }`}
        >
          ⭐ 経験値ランキング
        </button>
      </div>

      <div className="rpg-frame overflow-hidden">
        {(!ranking || ranking.length === 0) && (
          <div className="p-6 text-center text-muted-foreground">
            ランキングデータがありません
          </div>
        )}
        {ranking?.map((p, i) => (
          <div
            key={p.id}
            className="flex items-center gap-4 px-4 py-3 border-b border-border last:border-0"
          >
            <div className="w-8 text-center font-bold text-lg">
              {i === 0 ? "🥇" : i === 1 ? "🥈" : i === 2 ? "🥉" : `${i + 1}`}
            </div>
            <div className="flex-1 font-bold">{p.name}</div>
            <div className="text-sm font-mono">
              {tab === "rails" ? (
                <span className="text-gold">{p.rails.toLocaleString()} Rails</span>
              ) : (
                <span className="text-exp">{p.exp.toLocaleString()} EXP</span>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
