"use client";

import { useState, useEffect, useRef } from "react";
import { trpc } from "@/lib/trpc";

export default function ChatPage() {
  const [message, setMessage] = useState("");
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const { data: messages, refetch } = trpc.chat.messages.useQuery({ limit: 50 });
  const sendMutation = trpc.chat.send.useMutation({
    onSuccess: () => {
      setMessage("");
      refetch();
    },
  });

  useEffect(() => {
    const interval = setInterval(refetch, 3000);
    return () => clearInterval(interval);
  }, [refetch]);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  const handleSend = (e: React.FormEvent) => {
    e.preventDefault();
    if (!message.trim()) return;
    sendMutation.mutate({ message: message.trim() });
  };

  return (
    <div className="space-y-6 max-w-3xl mx-auto">
      <h1 className="font-heading text-3xl text-primary">💬 チャット</h1>

      <div className="rpg-frame p-4 h-96 overflow-y-auto space-y-2">
        {(!messages || messages.length === 0) && (
          <p className="text-muted-foreground text-center py-12">
            メッセージがありません
          </p>
        )}
        {messages?.map((msg) => (
          <div key={msg.id} className="flex gap-2">
            <span className="text-primary font-bold text-sm shrink-0">
              {msg.userName}:
            </span>
            <span className="text-sm">{msg.message}</span>
            <span className="text-xs text-muted-foreground shrink-0 ml-auto">
              {new Date(msg.createdAt).toLocaleTimeString("ja-JP")}
            </span>
          </div>
        ))}
        <div ref={messagesEndRef} />
      </div>

      <form onSubmit={handleSend} className="flex gap-3">
        <input
          type="text"
          value={message}
          onChange={(e) => setMessage(e.target.value)}
          placeholder="メッセージを入力..."
          maxLength={500}
          className="flex-1 px-4 py-2 rounded bg-secondary border border-border text-foreground focus:border-primary focus:outline-none"
        />
        <button
          type="submit"
          disabled={!message.trim() || sendMutation.isPending}
          className="px-6 py-2 rounded bg-primary text-primary-foreground font-bold hover:bg-primary/90 disabled:opacity-50"
        >
          送信
        </button>
      </form>
    </div>
  );
}
