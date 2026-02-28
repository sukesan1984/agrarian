"use client";

import { useState } from "react";
import { trpc } from "@/lib/trpc";
import { StatusPanel } from "@/components/game/status-panel";

export default function BankPage() {
  const { data: player, refetch: refetchPlayer } = trpc.player.me.useQuery();
  const { data: bank, refetch: refetchBank } = trpc.bank.status.useQuery();
  const [amount, setAmount] = useState("");

  const depositMutation = trpc.bank.deposit.useMutation({
    onSuccess: () => { refetchPlayer(); refetchBank(); setAmount(""); },
  });
  const withdrawMutation = trpc.bank.withdraw.useMutation({
    onSuccess: () => { refetchPlayer(); refetchBank(); setAmount(""); },
  });

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-2 space-y-6">
        <h1 className="font-heading text-3xl text-primary">🏦 銀行</h1>

        <div className="rpg-frame-gold p-6 space-y-4">
          <div className="flex justify-between text-sm">
            <span className="text-muted-foreground">預金残高</span>
            <span className="text-gold font-bold text-lg">
              {bank?.rails?.toLocaleString() ?? 0} Rails
            </span>
          </div>

          <div className="space-y-3">
            <input
              type="number"
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
              placeholder="金額を入力"
              min={1}
              className="w-full px-4 py-2 rounded bg-secondary border border-border text-foreground focus:border-primary focus:outline-none"
            />
            <div className="grid grid-cols-2 gap-3">
              <button
                onClick={() => depositMutation.mutate({ amount: Number(amount) })}
                disabled={!amount || depositMutation.isPending}
                className="py-3 rounded bg-primary text-primary-foreground font-bold hover:bg-primary/90 disabled:opacity-50"
              >
                預ける
              </button>
              <button
                onClick={() => withdrawMutation.mutate({ amount: Number(amount) })}
                disabled={!amount || withdrawMutation.isPending}
                className="py-3 rounded bg-secondary text-foreground font-bold hover:bg-secondary/80 disabled:opacity-50"
              >
                引き出す
              </button>
            </div>
          </div>
        </div>
      </div>

      <div>{player && <StatusPanel player={player} />}</div>
    </div>
  );
}
