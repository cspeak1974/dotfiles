from agent.loop import run_agent


def main() -> None:
    print("Agent ready. Type 'quit' to exit.\n")
    while True:
        try:
            user_input = input("You: ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\nExiting.")
            break
        if not user_input:
            continue
        if user_input.lower() in ("quit", "exit", "q"):
            break
        try:
            response = run_agent(user_input)
        except ValueError as e:
            print(f"\nError: {e}\n")
            continue
        print(f"\nAgent: {response}\n")


if __name__ == "__main__":
    main()
