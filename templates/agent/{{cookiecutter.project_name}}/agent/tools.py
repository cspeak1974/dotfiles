import datetime
from typing import Any

TOOLS: list[dict] = [
    {
        "name": "get_current_time",
        "description": "Returns the current UTC time in ISO 8601 format.",
        "input_schema": {
            "type": "object",
            "properties": {},
            "required": [],
        },
    },
]


def get_tools() -> list[dict]:
    return TOOLS


def run_tool(name: str, tool_input: dict[str, Any]) -> str:
    if name == "get_current_time":
        return datetime.datetime.now(datetime.timezone.utc).isoformat()
    raise ValueError(f"Unknown tool: {name}")
