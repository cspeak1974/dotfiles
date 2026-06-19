# CLAUDE.md — {{cookiecutter.project_name}}

This file provides context for Claude Code about this project.

## Overview

{{cookiecutter.description}}

## Project Structure

```
{{cookiecutter.project_name}}/
├── api/            ← FastAPI app package
│   ├── __init__.py
│   ├── __main__.py ← entry point: python -m api
│   ├── main.py     ← app factory and lifespan
│   ├── models.py   ← Pydantic request/response models
│   └── routes/     ← APIRouter modules
│       └── health.py
├── tests/          ← pytest tests (use TestClient)
├── docs/           ← architecture and design notes
├── .vscode/        ← VS Code workspace settings
├── .env            ← local credentials (never commit)
├── .env.example    ← environment variable template
├── .gitignore
├── Makefile
├── README.md
└── requirements.txt
```

## Environment Variables

See `.env.example` for required environment variables. Copy it to `.env` and fill in your values.

In production, secrets should be managed via a dedicated secret manager such as
HashiCorp Vault, AWS Secrets Manager, or Azure Key Vault, with environment
variables injected at runtime by the deployment platform.

## Key Design Decisions

### Hardcoded `api/` package name

The source package is always named `api/`, not `{{cookiecutter.project_slug}}/`. This keeps import
paths clean (`from api.routes import health`) and mirrors how other templates hardcode their
package name. The tradeoff: if you install two API projects into the same virtualenv, the package
names collide. To fix this, rename `api/` to match your project slug and update all imports.

### `load_dotenv()` in `api/main.py`

`load_dotenv()` is called at module import time in `main.py`, so any process that imports the
app automatically loads `.env`. Tests bypass this by relying on `TestClient`, which imports the
real app — so if you need to override env vars in tests, set them with `monkeypatch.setenv()`
before importing the module, or use `unittest.mock.patch.dict(os.environ, {...})`.

_Document your own design decisions below._

## Testing Guidelines

- Write tests for every new route or service function
- Use `fastapi.testclient.TestClient` for route tests — it runs the full ASGI stack without a live server
- **Never make real external API calls in tests** — mock external dependencies with `unittest.mock.patch`
- Always cover the happy path for every route (expected status code + response body)
- Cover at least one error path per route (e.g. missing field, bad input, dependency failure)
- Test files live in `tests/` and mirror the route module (e.g. `api/routes/orders.py` → `tests/test_orders.py`)
- Run tests with `make test`

## Running the API

```bash
make dev    # uvicorn with --reload (development)
make run    # python -m api (production-like, reads PORT from .env)
```

Interactive API docs are available at `http://localhost:8000/docs` when the server is running.

## Adding Routes

1. Create `api/routes/<name>.py` with a FastAPI `APIRouter`
2. Add request/response models to `api/models.py`
3. Register the router in `api/main.py` with `app.include_router(...)`
4. Add tests in `tests/test_<name>.py`

## Dotfiles & Scaffolding

This project was created with `new-py` from `github.com/cspeak1974/dotfiles`.

Available templates (use `new-py <name> -t <template>`):
- `scripts` — Python automation scripts
- `api` ✅ — FastAPI-based services and webhook receivers (this template)
- `package` — Reusable Python libraries with src/ layout
- `data` — Data analysis and pipeline projects
- `cli` — Command-line tools
- `agent` — Agentic AI projects (tool use, state management, LLM orchestration)

## What's Done

- [x] Project scaffolded

## What's Next

- [ ] Copy `.env.example` to `.env` and configure environment
- [ ] Run `make install` then `make dev`
- [ ] Add your routes under `api/routes/`
- [ ] Add Pydantic models to `api/models.py`
- [ ] Write tests for every route
- [ ] Update `docs/architecture.md`
- [ ] Polish README
