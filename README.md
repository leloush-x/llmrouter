# OmniRoute × Railway

Deploy [OmniRoute](https://github.com/diegosouzapw/OmniRoute) — the free MIT AI gateway (340+ providers behind one OpenAI-compatible endpoint) — on [Railway](https://railway.app) with minimal resource usage.

## Files

| File | Purpose |
|---|---|
| `Dockerfile` | Thin layer over official prebuilt image + volume-ownership fix for Railway |
| `railway.json` | Healthcheck-gated deploys (`/api/monitoring/health`), 1 replica |
| `.env.example` | Required variables |

## Deploy

1. Push this repo to GitHub → Railway → **New Service → GitHub Repo**
2. Attach a **Volume** (Service → Volumes) at mount path `/app/data` — persists SQLite DB, keys, config
3. Set variables:
   ```
   OMNIROUTE_WS_BRIDGE_SECRET=<openssl rand -hex 32>
   NEXT_PUBLIC_BASE_URL=https://<your-service>.up.railway.app
   ```
4. Deploy, open the domain → dashboard → **Endpoints** → copy API key
5. Point any tool at `https://<your-service>.up.railway.app/v1`, model `auto`

## Tuning

- `OMNIROUTE_MEMORY_MB=256` — lower heap for Hobby plan
- Pin `FROM diegosouzapw/omniroute:3.8.49` in the Dockerfile for stability
- No Redis needed for single instance (falls back to in-memory)
