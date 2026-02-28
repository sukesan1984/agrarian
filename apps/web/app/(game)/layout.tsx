"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { useSession } from "@/lib/auth-client";
import { GameHeader } from "@/components/layout/game-header";

export default function GameLayout({ children }: { children: React.ReactNode }) {
  const { data: session, isPending } = useSession();
  const router = useRouter();

  useEffect(() => {
    if (!isPending && !session) {
      router.push("/login");
    }
  }, [session, isPending, router]);

  if (isPending) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-primary font-heading text-xl animate-pulse">
          Loading...
        </div>
      </div>
    );
  }

  if (!session) return null;

  return (
    <div className="min-h-screen flex flex-col">
      <GameHeader />
      <main className="flex-1 max-w-7xl w-full mx-auto px-4 py-6">
        {children}
      </main>
      <footer className="border-t border-border py-4 text-center text-xs text-muted-foreground">
        Agrarian - Social RPG
      </footer>
    </div>
  );
}
