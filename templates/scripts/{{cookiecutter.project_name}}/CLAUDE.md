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

## What's Done

- [x] Project scaffolded

## What's Next

- [ ] Set up .env with credentials
- [ ] Install dependencies
- [ ] Write scripts
- [ ] Write tests
- [ ] Write architecture.md
- [ ] Polish README