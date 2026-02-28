"use client";

import { useEffect, useRef } from "react";
import { cn } from "@/lib/utils";

interface BattleLogProps {
  messages: string[];
  className?: string;
}

export function BattleLog({ messages, className }: BattleLogProps) {
  const endRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    endRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  return (
    <div
      className={cn(
        "rpg-frame p-4 max-h-60 overflow-y-auto font-mono text-sm space-y-1",
        className
      )}
    >
      {messages.length === 0 && (
        <p className="text-muted-foreground italic">---</p>
      )}
      {messages.map((msg, i) => (
        <p
          key={i}
          className={cn(
            "leading-relaxed",
            msg.includes("倒した") && "text-primary font-bold",
            msg.includes("力尽きた") && "text-destructive font-bold",
            msg.includes("レベルアップ") && "text-exp font-bold",
            msg.includes("回復") && "text-hp",
            msg.includes("ドロップ") && "text-gold font-bold"
          )}
        >
          {`> ${msg}`}
        </p>
      ))}
      <div ref={endRef} />
    </div>
  );
}
