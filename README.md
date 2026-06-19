# dotfiles

Personal development environment configuration for Clayton Speak.

## What's in here

- **scripts/** — shell scripts for development workflow
- **templates/** — Cookiecutter project templates for new Python projects
- **.claude/commands/** — global Claude Code slash commands
- **.vscode/** — VS Code workspace settings template

## Prerequisites

This dotfiles setup is designed for **WSL (Windows Subsystem for Linux)** running Ubuntu.

Before running `make install` make sure you have the following installed:

- **WSL2** with Ubuntu 24.04 or later
- **Python 3.9+** — `python3 --version`
- **Git** — `git --version`
- **VS Code** with the following extensions:
  - [Claude Code](https://marketplace.visualstudio.com/items?itemName=Anthropic.claude-code) — for AI-assisted development and slash commands
  - [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) — for Python language support
- **Make** — `make --version` (usually pre-installed on Ubuntu)

### Installing Make if missing

```bash
sudo apt install make -y
```

## Setup

Clone this repo and run:

```bash
git clone https://github.com/cspeak1974/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
source ~/.bashrc
```

The `make install` target will:
- Symlink Claude Code slash commands to `~/.claude/commands/` so they're available globally in every project
- Install `pipx` if not already installed
- Install `cookiecutter` via pipx if not already installed
- Add `~/dotfiles/scripts` to your PATH

## Creating a new Python project

`new-py` is an alias for `new-python-project.sh` defined in `~/.bashrc`. Make sure
you've sourced your shell after running `make install`.

```bash
new-py <project-name> [options]

Options:
  --template, -t     Template to use (default: scripts)
  --description, -d  Project description
  --author, -a       Project author
  --email, -e        Author email
  --python, -p       Python version

Templates: scripts, api, package, data, cli, agent
```

## Templates

### `scripts` (default)
For automation, tooling, and one-off scripts. Flat layout.

```
├── scripts/        ← your Python scripts
├── tests/          ← pytest tests
├── docs/           ← architecture and design notes
├── .vscode/        ← VS Code workspace settings
├── .env.example    ← environment variable template
├── .gitignore
├── Makefile
├── README.md
└── requirements.txt
```

### `api`
For FastAPI services and webhook receivers. Router-per-domain layout with Pydantic models, `TestClient` tests, and `make dev` for hot-reload.

```
api/
├── main.py         ← FastAPI app factory and lifespan
├── models.py       ← Pydantic request/response models
└── routes/
    └── health.py   ← GET /health
tests/
docs/
```

### `package` *(coming soon)*
For reusable Python libraries intended for PyPI distribution. Uses src layout.

### `data` *(coming soon)*
For data science and ML projects. Based on Cookiecutter Data Science standard with notebooks, data pipeline structure, and model directories.

### `cli` *(coming soon)*
For installable command line tools. Uses src layout with pyproject.toml.

### `agent`
For agentic AI projects — tool use, state management, and LLM orchestration with `claude-opus-4-8`.

```
├── agent/          ← agent package (client, tools, loop)
│   ├── client.py   ← Anthropic client factory
│   ├── loop.py     ← agentic loop
│   └── tools.py    ← tool definitions and execution
├── tests/          ← pytest tests
├── docs/           ← architecture and design notes
├── .vscode/        ← VS Code workspace settings
├── .env.example    ← environment variable template
├── .gitignore
├── Makefile
├── README.md
└── requirements.txt
```

## Claude Code slash commands

Custom slash commands available in Claude Code after running `make install`:

| Command | Description |
|---|---|
| `/commit` | Stage and commit changes with a generated message |
| `/commit --ai` | Same but adds Claude Co-Authored-By attribution |

## VS Code settings

The following settings are included automatically in all project templates:

```jsonc
{
    "terminal.integrated.defaultProfile.linux": "bash-venv",
    "terminal.integrated.automationProfile.linux": null,
    "python.terminal.useEnvFile": true,
    "python.envFile": "${workspaceFolder}/.env",
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
    "python.analysis.extraPaths": ["${workspaceFolder}/scripts"]
}
```

- `bash-venv` — activates `.venv` automatically on terminal open
- `python.terminal.useEnvFile` — injects `.env` variables into the terminal
- `python.envFile` — points VS Code to the `.env` file in the project root
- `python.defaultInterpreterPath` — explicitly points to `.venv` to fix interpreter detection
- `python.analysis.extraPaths` — adds `scripts/` to Pylance's analysis path, fixing import warnings

This is included automatically in all project templates.