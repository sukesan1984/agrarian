"use client";

import { cn } from "@/lib/utils";

interface HpGaugeProps {
  current: number;
  max: number;
  label?: string;
  className?: string;
}

export function HpGauge({ current, max, label = "HP", className }: HpGaugeProps) {
  const pct = max > 0 ? (current / max) * 100 : 0;
  const isCritical = pct < 25;

  return (
    <div className={cn("space-y-1", className)}>
      <div className="flex justify-between text-xs">
        <span className="text-muted-foreground">{label}</span>
        <span className={cn(isCritical && "text-destructive font-bold")}>
          {current} / {max}
        </span>
      </div>
      <div className="h-3 w-full rounded-sm bg-secondary overflow-hidden border border-border">
        <div
          className={cn(
            "h-full transition-all duration-500 ease-out rounded-sm",
            isCritical ? "bg-destructive hp-critical" : pct < 50 ? "bg-yellow-500" : "bg-hp"
          )}
          style={{ width: `${pct}%` }}
        />
      </div>
    </div>
  );
}
