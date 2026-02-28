"use client";

import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";

const SLOT_LABELS: Record<string, string> = {
  rightHand: "右手",
  leftHand: "左手",
  bothHand: "両手",
  body: "体",
  head: "頭",
  leg: "足",
  neck: "首",
  belt: "ベルト",
  amulet: "アミュレット",
  ringA: "指輪A",
  ringB: "指輪B",
};

export default function EquipmentPage() {
  const { data: player } = trpc.player.me.useQuery();
  const { data: equip, refetch: refetchEquip } = trpc.equipment.myEquipment.useQuery();
  const { data: available, refetch: refetchAvailable } = trpc.equipment.availableEquipment.useQuery();
  const equipMutation = trpc.equipment.equip.useMutation({
    onSuccess: () => { refetchEquip(); refetchAvailable(); },
  });
  const unequipMutation = trpc.equipment.unequip.useMutation({
    onSuccess: () => { refetchEquip(); refetchAvailable(); },
  });

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">⚔️ 装備</h1>

        <div className="rpg-frame p-6 space-y-4">
          <h2 className="font-heading text-lg text-primary">装備中</h2>
          <div className="grid grid-cols-2 gap-3">
            {equip &&
              Object.entries(SLOT_LABELS).map(([slot, label]) => {
                const equipAny = equip as Record<string, unknown>;
                const slots = equipAny.slots as Record<string, { userItemId: number; itemName: string; equipStats: { attack?: number | null; defense?: number | null } | null } | null> | undefined;
                const slotData = slots?.[slot] ?? null;
                const rawVal = !slots ? (equipAny[slot] as number | null) : null;
                const hasEquip = slotData !== null || (rawVal !== null && rawVal !== undefined && rawVal !== 0);

                return (
                  <div key={slot} className="rpg-frame p-3 flex items-center justify-between">
                    <div>
                      <div className="text-xs text-muted-foreground">{label}</div>
                      <div className="text-sm font-bold">
                        {slotData ? slotData.itemName : rawVal ? `装備 #${rawVal}` : "---"}
                      </div>
                      {slotData?.equipStats && (
                        <div className="text-xs text-muted-foreground">
                          {slotData.equipStats.attack ? `ATK:${slotData.equipStats.attack}` : ""}
                          {slotData.equipStats.attack && slotData.equipStats.defense ? " / " : ""}
                          {slotData.equipStats.defense ? `DEF:${slotData.equipStats.defense}` : ""}
                        </div>
                      )}
                    </div>
                    {hasEquip && (
                      <button
                        onClick={() => unequipMutation.mutate({ slot })}
                        className="px-2 py-1 text-xs rounded bg-secondary hover:bg-secondary/80"
                      >
                        外す
                      </button>
                    )}
                  </div>
                );
              })}
          </div>
        </div>

        <div className="rpg-frame p-6 space-y-4">
          <h2 className="font-heading text-lg text-primary">装備可能アイテム</h2>
          {(!available || available.length === 0) && (
            <p className="text-sm text-muted-foreground">装備可能なアイテムがありません</p>
          )}
          <div className="space-y-3">
            {available?.map((eq) => (
              <div key={eq.userItem.id} className="rpg-frame p-3 flex items-center justify-between">
                <div>
                  <div className="font-bold">{eq.item.name}</div>
                  <div className="text-xs text-muted-foreground">
                    ATK: {eq.equipment.attack ?? 0} | DEF: {eq.equipment.defense ?? 0}
                  </div>
                  {eq.affixes.length > 0 && (
                    <div className="text-xs text-primary mt-1">
                      {eq.affixes.map((a) => a.affix.name).join(", ")}
                    </div>
                  )}
                </div>
                <button
                  onClick={() => equipMutation.mutate({ userItemId: eq.userItem.id })}
                  disabled={equipMutation.isPending}
                  className="px-3 py-1.5 text-xs rounded bg-primary text-primary-foreground hover:bg-primary/80 disabled:opacity-50"
                >
                  装備
                </button>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div>{player && <StatusPanel player={player} />}</div>
    </div>
  );
}
