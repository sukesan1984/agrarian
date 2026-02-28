"use client";

import { trpc } from "@/lib/trpc";

const STATUS_LABELS: Record<number, string> = {
  0: "未受注",
  1: "進行中",
  2: "完了",
};

export default function QuestPage() {
  const { data: quests, isLoading, refetch } = trpc.quest.list.useQuery();
  const acceptMutation = trpc.quest.accept.useMutation({
    onSuccess: () => refetch(),
  });
  const claimMutation = trpc.quest.claim.useMutation({
    onSuccess: () => refetch(),
  });

  return (
    <div className="space-y-6">
      <h1 className="font-heading text-3xl text-primary">📜 クエスト</h1>

      {isLoading && <div className="text-muted-foreground">読み込み中...</div>}

      {quests && quests.length === 0 && (
        <div className="rpg-frame p-6 text-center text-muted-foreground">
          クエストがありません
        </div>
      )}

      <div className="space-y-3">
        {quests?.map((q) => (
          <div key={q.id} className="rpg-frame p-4 space-y-2">
            <div className="flex items-center justify-between">
              <div>
                <div className="font-bold">{q.name}</div>
                <div className="text-xs text-muted-foreground">{q.description}</div>
                <div className="text-xs mt-1">
                  <span
                    className={
                      q.status === 2
                        ? "text-hp"
                        : q.status === 1
                          ? "text-primary"
                          : "text-muted-foreground"
                    }
                  >
                    {STATUS_LABELS[q.status] ?? "不明"}
                  </span>
                </div>
              </div>
              <div className="flex gap-2">
                {q.status === 0 && (
                  <button
                    onClick={() => acceptMutation.mutate({ questId: q.id })}
                    disabled={acceptMutation.isPending}
                    className="px-3 py-1.5 text-xs rounded bg-primary text-primary-foreground hover:bg-primary/80 disabled:opacity-50"
                  >
                    受注
                  </button>
                )}
                {q.status === 1 && "conditionsMet" in q && q.conditionsMet && (
                  <button
                    onClick={() => claimMutation.mutate({ questId: q.id })}
                    disabled={claimMutation.isPending}
                    className="px-3 py-1.5 text-xs rounded bg-hp text-primary-foreground hover:bg-hp/80 disabled:opacity-50"
                  >
                    報酬受取
                  </button>
                )}
              </div>
            </div>

            {q.status === 1 && q.conditions && q.conditions.length > 0 && (
              <div className="space-y-1 pt-1 border-t border-border">
                {q.conditions.map((c, i) => (
                  <div key={i} className="flex items-center justify-between text-xs">
                    <span className="text-muted-foreground">{c.description}</span>
                    <span className={c.current >= c.required ? "text-hp font-bold" : "text-muted-foreground"}>
                      {c.current} / {c.required}
                    </span>
                  </div>
                ))}
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
