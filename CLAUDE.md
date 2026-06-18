# CLAUDE.md — dotfiles

Personal development environment for Clayton Speak (WSL2/Ubuntu).

## What's in here

```
dotfiles/
├── .claude/commands/   ← global Claude Code slash commands (symlinked to ~/.claude/commands/)
├── scripts/            ← shell scripts on PATH (~/.bashrc adds ~/dotfiles/scripts)
├── templates/          ← Cookiecutter project templates
│   ├── agent/          ← agentic AI projects (Anthropic SDK, tool use)
│   └── scripts/        ← Python automation scripts (default)
├── Makefile            ← dotfiles setup (make install)
└── README.md
```

## Key Entry Points

- `make install` — symlinks slash commands, installs pipx + cookiecutter, adds scripts to PATH
- `new-py <name> [-t template]` — alias for `scripts/new-python-project.sh`; scaffolds a new project into `~/projects/source/repos/`

## Adding a New Template

1. Create `templates/<name>/cookiecutter.json` with the same fields as `templates/scripts/cookiecutter.json`
2. Create `templates/<name>/{{cookiecutter.project_name}}/` with the project scaffold
3. Add the template name to the help text in `scripts/new-python-project.sh` (two places: `--help` output and error message)
4. Document it in `README.md` under the Templates section
5. List it in `CLAUDE.md` in the templates built in this project (below)
6. List it in the `Dotfiles & Scaffolding` section of every template's `CLAUDE.md`

## Templates

| Template  | Status      | Description                                     |
|-----------|-------------|-------------------------------------------------|
| `scripts` | ✅ Built    | Python automation scripts, flat layout          |
| `agent`   | ✅ Built    | Agentic AI projects (Anthropic SDK, tool use)   |
| `api`     | Coming soon | FastAPI/Flask services                          |
| `package` | Coming soon | Reusable Python libraries (src layout, PyPI)    |
| `data`    | Coming soon | Data science / ML projects                      |
| `cli`     | Coming soon | Installable command-line tools                  |

## Template Conventions

All templates share these conventions:

- `.venv/` managed by `make install` (`python3 -m venv .venv`)
- All `make` targets use `.venv/bin/python`, `.venv/bin/pytest`, etc. explicitly
- `pyproject.toml` configures ruff (line-length 100, E/F/I rules) and pytest (`pythonpath = ["."]`)
- `.vscode/settings.json` sets `bash-venv` terminal profile (auto-activates `.venv`) and `python.envFile`
- `CLAUDE.md` includes project structure, testing guidelines, and key design decisions
- Tests mock all external calls — never make real API/network calls in tests

## Slash Commands

Global commands live in `.claude/commands/` and are symlinked to `~/.claude/commands/` by `make install`.

| Command   | Description                                          |
|-----------|------------------------------------------------------|
| `/commit` | Stage and commit with a conventional commit message  |
