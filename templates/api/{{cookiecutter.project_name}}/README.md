# {{cookiecutter.project_name}}

{{cookiecutter.description}}

## Quick Start

```bash
# 1. Install dependencies
make install

# 2. Set up environment
cp .env.example .env
# Edit .env if needed

# 3. Run the dev server
make dev
```

The API will be available at `http://localhost:8000`.
Interactive docs at `http://localhost:8000/docs`.

## Development

```bash
make test    # run tests
make lint    # ruff linter
make format  # ruff formatter
make clean   # remove cache artifacts
```

## Project Layout

```
api/
├── main.py         ← FastAPI app factory
├── models.py       ← Pydantic request/response models
└── routes/
    └── health.py   ← GET /health
tests/
docs/
```

## Adding Routes

1. Create `api/routes/<name>.py` with a FastAPI `APIRouter`
2. Add request/response models to `api/models.py`
3. Register the router in `api/main.py` with `app.include_router(...)`
4. Add tests in `tests/test_<name>.py`

## Architecture

See [docs/architecture.md](docs/architecture.md).
