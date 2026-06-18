# CLAUDE.md — {{cookiecutter.project_name}}

This file provides context for Claude Code about this project.

## Overview

{{cookiecutter.description}}

## Project Structure

```
{{cookiecutter.project_name}}/
├── scripts/        ← Python scripts
├── tests/          ← pytest tests
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

See `.env.example` for required environment variables.

In production, secrets should be managed via a dedicated secret manager such as
HashiCorp Vault, AWS Secrets Manager, or Azure Key Vault, with environment
variables injected at runtime by the deployment platform.

## Key Design Decisions

_Document your key design decisions here._

## Testing Guidelines

- Write tests for every new script or function
- Use `pytest` as the test framework
- Mock all external API calls using `unittest.mock.patch` — never make real API calls in tests
- Always cover the happy path for every function
- Cover at least one error/sad path per function (e.g. API returns 4xx, missing env vars)
- Test files live in `tests/` and mirror the script name (e.g. `scripts/joiner.py` → `tests/test_joiner.py`)
- Run tests with `make test`

## Dotfiles & Scaffolding

This project was created with `new-py` from `github.com/cspeak1974/dotfiles`.

Available templates (use `new-py <name> -t <template>`):
- `scripts` ✅ — Python automation scripts (this template)
- `api` — FastAPI-based services and webhook receivers
- `package` — Reusable Python libraries with src/ layout
- `data` — Data analysis and pipeline projects
- `cli` — Command-line tools
- `agent` — Agentic AI projects (tool use, state management, LLM orchestration)

## What's Done

- [x] Project scaffolded

## What's Next

- [ ] Set up .env with credentials
- [ ] Install dependencies
- [ ] Write scripts
- [ ] Write tests
- [ ] Write architecture.md
- [ ] Polish README