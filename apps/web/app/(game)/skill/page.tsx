"use client";

import { trpc } from "@/lib/trpc";

export default function SkillPage() {
  const { data: skills, isLoading } = trpc.skill.list.useQuery();

  return (
    <div className="space-y-6">
      <h1 className="font-heading text-3xl text-primary">✨ スキル</h1>

      {isLoading && <div className="text-muted-foreground">読み込み中...</div>}

      {skills && skills.length === 0 && (
        <div className="rpg-frame p-6 text-center text-muted-foreground">
          スキルがありません
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {skills?.map((s) => (
          <div key={s.id} className="rpg-frame p-4">
            <div className="flex justify-between items-center">
              <div className="font-bold">{s.name}</div>
              <div className="text-sm text-primary font-mono">
                Lv.{s.skillPoint}
              </div>
            </div>
            {s.description && (
              <div className="text-xs text-muted-foreground mt-1">{s.description}</div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
