import pytest

from agent.tools import get_tools, run_tool


def test_get_tools_returns_list():
    tools = get_tools()
    assert isinstance(tools, list)
    assert len(tools) > 0


def test_each_tool_has_required_keys():
    for tool in get_tools():
        assert "name" in tool
        assert "description" in tool
        assert "input_schema" in tool


def test_run_tool_get_current_time():
    result = run_tool("get_current_time", {})
    assert isinstance(result, str)
    assert "T" in result  # ISO 8601 datetime contains T separator


def test_run_tool_unknown_raises():
    with pytest.raises(ValueError, match="Unknown tool"):
        run_tool("nonexistent_tool", {})
