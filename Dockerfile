# Single container: built frontend served by the FastAPI backend on port 8000.
FROM node:22-slim AS web
WORKDIR /web
COPY frontend/package*.json ./
# `npm ci` needs a lockfile; fall back to `npm install` until you have committed one.
RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi
COPY frontend/ ./
RUN npm run build

FROM python:3.12-slim
WORKDIR /app
COPY backend/requirements.txt backend/requirements.txt
RUN pip install --no-cache-dir -r backend/requirements.txt
COPY backend/app backend/app
COPY --from=web /web/dist frontend/dist
# Local SQLite + uploads live here until the cloud move (milestone M1).
ENV APP_DATA_DIR=/app/data
RUN mkdir -p /app/data
# Run as a non-root user (uid 1000 also suits hosts such as Hugging Face Spaces).
RUN useradd -m -u 1000 app && chown -R app:app /app
USER app

WORKDIR /app/backend
EXPOSE 8000
# PORT is honoured so the same image runs behind hosts that inject one.
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
