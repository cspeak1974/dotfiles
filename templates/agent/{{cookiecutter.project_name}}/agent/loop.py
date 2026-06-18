import anthropic

from agent.client import get_client
from agent.tools import get_tools, run_tool

MODEL = "claude-opus-4-8"


def run_agent(user_message: str, system: str | None = None) -> str:
    client = get_client()
    messages: list[dict] = [{"role": "user", "content": user_message}]
    kwargs: dict = {
        "model": MODEL,
        "max_tokens": 8192,
        "thinking": {"type": "adaptive"},
        "tools": get_tools(),
        "messages": messages,
    }
    if system:
        kwargs["system"] = system

    while True:
        with client.messages.stream(**kwargs) as stream:
            response = stream.get_final_message()

        if response.stop_reason == "end_turn":
            for block in response.content:
                if block.type == "text":
                    return block.text
            return ""

        if response.stop_reason == "tool_use":
            messages.append({"role": "assistant", "content": response.content})

            tool_results = []
            for block in response.content:
                if block.type == "tool_use":
                    result = run_tool(block.name, block.input)
                    tool_results.append({
                        "type": "tool_result",
                        "tool_use_id": block.id,
                        "content": result,
                    })

            messages.append({"role": "user", "content": tool_results})
            kwargs["messages"] = messages
        else:
            break

    return ""
