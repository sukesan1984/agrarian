"use client";

import { cn } from "@/lib/utils";
import { HpGauge } from "./hp-gauge";

interface StatusPanelProps {
  player: {
    name: string;
    hp: number;
    hpMax: number;
    rails: number;
    str: number;
    dex: number;
    vit: number;
    ene: number;
    exp: number;
    remainingPoints: number;
  };
  className?: string;
  compact?: boolean;
}

export function StatusPanel({ player, className, compact }: StatusPanelProps) {
  return (
    <div className={cn("rpg-frame p-4 space-y-3", className)}>
      <h3 className="font-heading text-primary text-lg font-bold">
        {player.name}
      </h3>

      <HpGauge current={player.hp} max={player.hpMax} />

      <div className="flex items-center gap-2 text-sm">
        <span className="text-gold font-bold">💰</span>
        <span className="text-gold">{player.rails.toLocaleString()} Rails</span>
      </div>

      {!compact && (
        <>
          <div className="grid grid-cols-2 gap-2 text-sm">
            <StatRow label="STR" value={player.str} />
            <StatRow label="DEX" value={player.dex} />
            <StatRow label="VIT" value={player.vit} />
            <StatRow label="ENE" value={player.ene} />
          </div>

          <div className="text-xs text-muted-foreground space-y-1">
            <div className="flex justify-between">
              <span>EXP</span>
              <span className="text-exp">{player.exp.toLocaleString()}</span>
            </div>
            {player.remainingPoints > 0 && (
              <div className="flex justify-between text-primary">
                <span>未割当ポイント</span>
                <span>{player.remainingPoints}</span>
              </div>
            )}
          </div>
        </>
      )}
    </div>
  );
}

function StatRow({ label, value }: { label: string; value: number }) {
  return (
    <div className="flex justify-between px-2 py-1 rounded bg-secondary/50">
      <span className="text-muted-foreground">{label}</span>
      <span className="font-mono font-bold">{value}</span>
    </div>
  );
}
