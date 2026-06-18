# CLAUDE.md — {{cookiecutter.project_name}}

This file provides context for Claude Code about this project.

## Overview

{{cookiecutter.description}}

## Project Structure

```
{{cookiecutter.project_name}}/
├── agent/          ← agent package (client, tools, loop)
│   ├── __init__.py
│   ├── __main__.py ← entry point: python -m agent
│   ├── client.py   ← Anthropic client factory
│   ├── loop.py     ← agentic loop
│   └── tools.py    ← tool definitions and execution
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

See `.env.example` for required environment variables. Copy it to `.env` and fill in your values.

In production, secrets should be managed via a dedicated secret manager such as
HashiCorp Vault, AWS Secrets Manager, or Azure Key Vault, with environment
variables injected at runtime by the deployment platform.

## Key Design Decisions

### Hardcoded `agent/` package name

The source package is always named `agent/`, not `{{cookiecutter.project_slug}}/`. This keeps import
paths clean (`from agent.tools import ...`) and mirrors how the `scripts` template hardcodes
`scripts/`. The tradeoff: if you install two agent projects into the same virtualenv, the package
names collide. To fix this, rename `agent/` to match your project slug and update all imports.

_Document your own design decisions below._

## Testing Guidelines

- Write tests for every new function or module
- Use `pytest` as the test framework
- **Never make real API calls in tests** — mock `agent.loop.get_client` (and `agent.client.get_client`) using `unittest.mock.patch`
- Always cover the happy path for every function
- Cover at least one error/sad path per function (e.g. unknown tool name, missing API key)
- Test files live in `tests/` and mirror the module name (e.g. `agent/tools.py` → `tests/test_tools.py`)
- Run tests with `make test`

## How the Loop Works

`run_agent()` in `agent/loop.py` runs a streaming agentic loop against `claude-opus-4-8` with
adaptive thinking enabled. Each iteration:

1. Calls `client.messages.stream()` and collects the final message via `get_final_message()`
2. If `stop_reason == "tool_use"`: executes all tool calls, appends results, and loops
3. If `stop_reason == "end_turn"`: returns the first text block

To change the model, update `MODEL` at the top of `agent/loop.py`.

`load_dotenv()` is called at import time in `client.py`, so any file that imports from the
`agent` package automatically loads `.env`. Tests bypass this by mocking `get_client` rather
than loading real credentials.

## Adding Tools

1. Add a tool definition to `TOOLS` in `agent/tools.py`
2. Add a matching branch in `run_tool()` in `agent/tools.py`
3. Add tests in `tests/test_tools.py`

## Dotfiles & Scaffolding

This project was created with `new-py` from `github.com/cspeak1974/dotfiles`.

Available templates (use `new-py <name> -t <template>`):
- `scripts` — Python automation scripts
- `api` — FastAPI-based services and webhook receivers
- `package` — Reusable Python libraries with src/ layout
- `data` — Data analysis and pipeline projects
- `cli` — Command-line tools
- `agent` ✅ — Agentic AI projects (this template)

## What's Done

- [x] Project scaffolded

## What's Next

- [ ] Copy `.env.example` to `.env` and set `ANTHROPIC_API_KEY`
- [ ] Run `make install`
- [ ] Replace `get_current_time` with your own tools
- [ ] Write tests for your tools
- [ ] Update `docs/architecture.md`
- [ ] Polish README
