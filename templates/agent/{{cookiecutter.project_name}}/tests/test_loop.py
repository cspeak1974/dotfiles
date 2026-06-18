from unittest.mock import MagicMock, patch

from agent.loop import run_agent


def _make_stream(stop_reason: str, content_blocks: list) -> MagicMock:
    response = MagicMock()
    response.stop_reason = stop_reason
    response.content = content_blocks

    stream = MagicMock()
    stream.__enter__ = MagicMock(return_value=stream)
    stream.__exit__ = MagicMock(return_value=False)
    stream.get_final_message.return_value = response
    return stream


def _text_block(text: str) -> MagicMock:
    block = MagicMock()
    block.type = "text"
    block.text = text
    return block


def _tool_block(name: str, tool_input: dict) -> MagicMock:
    block = MagicMock()
    block.type = "tool_use"
    block.id = "tool_abc123"
    block.name = name
    block.input = tool_input
    return block


def test_run_agent_returns_text_on_end_turn():
    stream = _make_stream("end_turn", [_text_block("Hello!")])

    with patch("agent.loop.get_client") as mock_get_client:
        mock_client = MagicMock()
        mock_client.messages.stream.return_value = stream
        mock_get_client.return_value = mock_client

        result = run_agent("Say hello")

    assert result == "Hello!"


def test_run_agent_executes_tool_then_returns():
    stream_1 = _make_stream("tool_use", [_tool_block("get_current_time", {})])
    stream_2 = _make_stream("end_turn", [_text_block("The time has been retrieved.")])

    with patch("agent.loop.get_client") as mock_get_client:
        mock_client = MagicMock()
        mock_client.messages.stream.side_effect = [stream_1, stream_2]
        mock_get_client.return_value = mock_client

        result = run_agent("What time is it?")

    assert result == "The time has been retrieved."
    assert mock_client.messages.stream.call_count == 2


def test_run_agent_passes_system_prompt():
    stream = _make_stream("end_turn", [_text_block("OK")])

    with patch("agent.loop.get_client") as mock_get_client:
        mock_client = MagicMock()
        mock_client.messages.stream.return_value = stream
        mock_get_client.return_value = mock_client

        run_agent("Hi", system="You are a helpful assistant.")
        _, call_kwargs = mock_client.messages.stream.call_args

    assert call_kwargs["system"] == "You are a helpful assistant."


def test_run_agent_no_system_prompt_by_default():
    stream = _make_stream("end_turn", [_text_block("OK")])

    with patch("agent.loop.get_client") as mock_get_client:
        mock_client = MagicMock()
        mock_client.messages.stream.return_value = stream
        mock_get_client.return_value = mock_client

        run_agent("Hi")
        _, call_kwargs = mock_client.messages.stream.call_args

    assert "system" not in call_kwargs
