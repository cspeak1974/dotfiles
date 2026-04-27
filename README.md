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

```bash
new-py <project-name> [options]

Options:
  --template, -t     Template to use (default: scripts)
  --description, -d  Project description
  --author, -a       Project author
  --email, -e        Author email
  --python, -p       Python version

Templates: scripts, api, package, data, cli
```

## Claude Code slash commands

Custom slash commands available in Claude Code after running `make install`:

| Command | Description |
|---|---|
| `/commit` | Stage and commit changes with a generated message |
| `/commit --ai` | Same but adds Claude Co-Authored-By attribution |

## VS Code settings

The `bash-venv` terminal profile activates `.venv` automatically when opening
a terminal in any project that has a virtual environment. Add this to your
workspace `.vscode/settings.json`:

```jsonc
{
    "terminal.integrated.defaultProfile.linux": "bash-venv",
    "terminal.integrated.automationProfile.linux": null
}
```

This is included automatically in all project templates.