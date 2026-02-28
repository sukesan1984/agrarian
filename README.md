# Agrarian

レトロ風ソーシャル RPG ゲーム「agrarian」のリポジトリです。

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Next.js 16 (App Router) / React 19 / Tailwind CSS v4 |
| Backend | Hono + tRPC v11 |
| Database | PostgreSQL 16 (Drizzle ORM) |
| Auth | Better Auth |
| Infra | Docker Compose (PostgreSQL, Redis) |
| Monorepo | Turborepo + pnpm workspaces |

## Project Structure

```
├── apps/
│   ├── web/          # Next.js frontend
│   └── server/       # Hono + tRPC backend
├── packages/
│   └── db/           # Drizzle schema & seed
├── docker-compose.yml
├── turbo.json
└── pnpm-workspace.yaml
```

## Getting Started

### Prerequisites

- Node.js 22+
- pnpm 9+
- Docker & Docker Compose

### Setup

```bash
# Install dependencies
pnpm install

# Start PostgreSQL & Redis
docker compose up -d

# Copy environment files
cp .env.example .env
cp .env apps/server/.env
cp .env packages/db/.env

# Push database schema
pnpm db:push

# Seed initial data
pnpm db:seed

# Start dev servers
pnpm dev
```

Frontend runs on `http://localhost:3000`, backend on `http://localhost:3100`.

## Game Features

- Character creation & stat allocation
- World exploration (towns, roads, dungeons)
- Turn-based combat with enemy encounters
- Equipment system with affixes
- Shops, inns, banking
- Quest system with conditions tracking
- Crafting recipes & skills
- Mercenary party management
- Rankings & chat
