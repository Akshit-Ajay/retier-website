# ReTier

Campus reuse platform: scan an item, find out if it is really trash, and give useful items a second life.
Four tiers: 1 Reuse As-Is, 2 Repair-Worthy, 3 Parts-Salvageable, 4 True Waste. A human verifies tier decisions.

**Status:** milestone M0 (cleanup). See `docs/ARCHITECTURE.md`. The image classifier is still a placeholder.

Built on a generic FastAPI + React skeleton; the ReTier logic (scan flow, tiers, verification, impact) is original.
Credit and licence notes for the reference project go here before the repo is made public.

## Layout

```
backend/app/    main.py (app factory) · config.py · db.py (SQLite) · schemas.py
                api/routes.py (HTTP only) · services/classifier.py (no FastAPI imports)
backend/tests/  pytest, uses a temp data dir
frontend/src/   App.tsx · pages/ · components/ · lib/ (api.ts, types.ts, useAsync.ts)
data/           retier.db and uploads/ are created at runtime (gitignored)
```

## Run on Windows (Command Prompt, no make)

```
py -3.12 -m venv .venv
.venv\Scripts\python.exe -m pip install -r backend\requirements-dev.txt
cd backend
..\.venv\Scripts\python.exe -m pytest -q
..\.venv\Scripts\python.exe -m uvicorn app.main:app --reload --port 8000
```

In a second window:

```
cd frontend
npm install
npm test
npm run dev:phone
```

## Docker

```
docker compose up --build     # http://localhost:8000
```
