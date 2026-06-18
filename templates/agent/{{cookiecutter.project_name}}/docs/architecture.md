# Architecture

_Document your architecture decisions here._

## Overview

## Components

### `agent/client.py`

Creates and returns the Anthropic client. Loads credentials from `.env` via `python-dotenv`.

### `agent/tools.py`

Defines available tools (`TOOLS`) and handles their execution (`run_tool`). Add new tools here.

### `agent/loop.py`

Runs the agentic loop: sends the user message to Claude, handles tool calls until `stop_reason == "end_turn"`, and returns the final text response.

## Data Flow

```
User input
  → run_agent() in loop.py
  → messages.stream() → Claude (claude-opus-4-8)
  → if stop_reason == "tool_use": run_tool() → append result → repeat
  → if stop_reason == "end_turn": return text
```

## Key Decisions

_Document key decisions here, e.g. why you chose certain tools, model, max_tokens, etc._
