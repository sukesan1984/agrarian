"use client";

import Link from "next/link";
import { signOut, useSession } from "@/lib/auth-client";
import { useRouter } from "next/navigation";

export function GameHeader() {
  const { data: session } = useSession();
  const router = useRouter();

  const handleSignOut = async () => {
    await signOut();
    router.push("/login");
  };

  return (
    <header className="border-b border-border bg-card/80 backdrop-blur-sm sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 h-14 flex items-center justify-between">
        <Link href="/home" className="font-heading text-2xl text-primary font-bold tracking-wider">
          Agrarian
        </Link>

        <nav className="hidden md:flex items-center gap-6 text-sm">
          <NavLink href="/home">ホーム</NavLink>
          <NavLink href="/inventory">アイテム</NavLink>
          <NavLink href="/equipment">装備</NavLink>
          <NavLink href="/quest">クエスト</NavLink>
          <NavLink href="/recipe">レシピ</NavLink>
          <NavLink href="/ranking">ランキング</NavLink>
          <NavLink href="/chat">チャット</NavLink>
        </nav>

        <div className="flex items-center gap-4">
          {session?.user && (
            <>
              <span className="text-xs text-muted-foreground hidden sm:inline">
                {session.user.name}
              </span>
              <button
                onClick={handleSignOut}
                className="text-xs text-muted-foreground hover:text-foreground transition-colors"
              >
                ログアウト
              </button>
            </>
          )}
        </div>
      </div>
    </header>
  );
}

function NavLink({ href, children }: { href: string; children: React.ReactNode }) {
  return (
    <Link
      href={href}
      className="text-muted-foreground hover:text-primary transition-colors"
    >
      {children}
    </Link>
  );
}
