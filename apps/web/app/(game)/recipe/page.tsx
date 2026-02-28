"use client";

import { trpc } from "@/lib/trpc";

export default function RecipePage() {
  const { data: recipes, isLoading, refetch } = trpc.recipe.list.useQuery();
  const makeMutation = trpc.recipe.make.useMutation({
    onSuccess: () => refetch(),
  });

  return (
    <div className="space-y-6">
      <h1 className="font-heading text-3xl text-primary">🔨 レシピ</h1>

      {isLoading && <div className="text-muted-foreground">読み込み中...</div>}

      {recipes && recipes.length === 0 && (
        <div className="rpg-frame p-6 text-center text-muted-foreground">
          レシピがありません
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {recipes?.map((r) => (
          <div key={r.id} className="rpg-frame p-4 space-y-3">
            <div className="font-bold text-primary">
              {r.productItem?.name ?? `Item #${r.productItemId}`} x{r.productItemCount}
            </div>
            {r.difficulty && (
              <div className="text-xs text-muted-foreground">難易度: {r.difficulty}</div>
            )}
            <button
              onClick={() => makeMutation.mutate({ recipeId: r.id })}
              disabled={makeMutation.isPending}
              className="w-full py-2 rounded bg-primary text-primary-foreground text-sm font-bold hover:bg-primary/80 disabled:opacity-50"
            >
              作成
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}
