# {{cookiecutter.project_name}}

{{cookiecutter.description}}

## Quick Start

```bash
# 1. Set up credentials
cp .env.example .env
# Edit .env and set ANTHROPIC_API_KEY

# 2. Install dependencies
make install

# 3. Run the agent
make run
```

## Development

```bash
make test    # run tests
make lint    # ruff linter
make format  # ruff formatter
make clean   # remove cache artifacts
```

## Project Layout

```
agent/
├── client.py   ← Anthropic client factory
├── loop.py     ← agentic loop (main logic)
└── tools.py    ← tool definitions and execution
tests/
docs/
```

## Adding Tools

1. Add a tool definition to `TOOLS` in [agent/tools.py](agent/tools.py)
2. Add a matching branch to `run_tool()` in the same file
3. Add tests in [tests/test_tools.py](tests/test_tools.py)

## Architecture

See [docs/architecture.md](docs/architecture.md).
