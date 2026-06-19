# Architecture

_Document your architecture decisions here._

## Overview

## Components

### `api/main.py`

FastAPI app factory. Registers routers and configures the lifespan context. Loads credentials
from `.env` via `python-dotenv`.

### `api/models.py`

Pydantic request and response models shared across routes.

### `api/routes/health.py`

Health check endpoint at `GET /health`. Returns `{"status": "ok"}`. Useful for load balancers
and uptime monitors.

## Data Flow

```
HTTP request
  → FastAPI router dispatch (api/main.py)
  → route handler (api/routes/*.py)
  → Pydantic validation (api/models.py)
  → response
```

## Key Decisions

_Document key decisions here, e.g. why you chose certain packages, database drivers, auth strategy, etc._
