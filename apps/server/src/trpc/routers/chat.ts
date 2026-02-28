import { z } from "zod";
import { router, protectedProcedure } from "../trpc";

const chatMessages: {
  id: number;
  userId: string;
  userName: string;
  message: string;
  createdAt: Date;
}[] = [];

let nextId = 1;

export const chatRouter = router({
  messages: protectedProcedure
    .input(z.object({ limit: z.number().min(1).max(100).default(50) }))
    .query(({ input }) => {
      return chatMessages.slice(-input.limit);
    }),

  send: protectedProcedure
    .input(z.object({ message: z.string().min(1).max(500) }))
    .mutation(({ ctx, input }) => {
      const msg = {
        id: nextId++,
        userId: ctx.user.id,
        userName: ctx.user.name,
        message: input.message,
        createdAt: new Date(),
      };
      chatMessages.push(msg);
      if (chatMessages.length > 1000) {
        chatMessages.splice(0, chatMessages.length - 1000);
      }
      return msg;
    }),
});
