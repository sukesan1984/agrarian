"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { signUp } from "@/lib/auth-client";

export default function RegisterPage() {
  const router = useRouter();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setLoading(true);

    try {
      const result = await signUp.email({ name, email, password });
      if (result.error) {
        setError(result.error.message ?? "登録に失敗しました");
      } else {
        router.push("/home");
      }
    } catch {
      setError("登録に失敗しました");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center px-4">
      <div className="w-full max-w-md space-y-8">
        <div className="text-center">
          <h1 className="font-heading text-5xl text-primary font-bold tracking-wider">
            Agrarian
          </h1>
          <p className="mt-2 text-muted-foreground text-sm">
            新しい冒険者の登録
          </p>
        </div>

        <form onSubmit={handleSubmit} className="rpg-frame-gold p-8 space-y-6">
          <h2 className="font-heading text-xl text-center">新規登録</h2>

          {error && (
            <div className="p-3 rounded bg-destructive/10 border border-destructive/30 text-destructive text-sm">
              {error}
            </div>
          )}

          <div className="space-y-2">
            <label className="text-sm text-muted-foreground">名前</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="w-full px-4 py-2 rounded bg-secondary border border-border text-foreground focus:border-primary focus:outline-none transition-colors"
              required
            />
          </div>

          <div className="space-y-2">
            <label className="text-sm text-muted-foreground">メールアドレス</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full px-4 py-2 rounded bg-secondary border border-border text-foreground focus:border-primary focus:outline-none transition-colors"
              required
            />
          </div>

          <div className="space-y-2">
            <label className="text-sm text-muted-foreground">パスワード</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full px-4 py-2 rounded bg-secondary border border-border text-foreground focus:border-primary focus:outline-none transition-colors"
              minLength={8}
              required
            />
          </div>

          <button
            type="submit"
            disabled={loading}
            className="w-full py-3 rounded bg-primary text-primary-foreground font-bold hover:bg-primary/90 transition-colors disabled:opacity-50"
          >
            {loading ? "登録中..." : "冒険を始める"}
          </button>

          <p className="text-center text-sm text-muted-foreground">
            既にアカウントをお持ちの方は{" "}
            <Link href="/login" className="text-primary hover:underline">
              ログイン
            </Link>
          </p>
        </form>
      </div>
    </div>
  );
}
