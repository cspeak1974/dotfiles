.DEFAULT_GOAL := help

.PHONY: help install

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Set up dotfiles on a new machine
	@echo "🚀 Setting up dotfiles..."

	@echo "📁 Setting up Claude Code global commands..."
	@mkdir -p ~/.claude/commands
	@for cmd in $(HOME)/dotfiles/.claude/commands/*.md; do \
		filename=$$(basename "$$cmd"); \
		target="$(HOME)/.claude/commands/$$filename"; \
		if [ -L "$$target" ]; then \
			echo "  ↩️  Skipping $$filename (already symlinked)"; \
		else \
			ln -s "$$cmd" "$$target"; \
			echo "  ✅ Linked $$filename"; \
		fi \
	done

	@echo "📦 Checking pipx..."
	@if ! command -v pipx &> /dev/null; then \
		echo "  Installing pipx..."; \
		sudo apt install pipx -y; \
		pipx ensurepath; \
	else \
		echo "  ✅ pipx already installed"; \
	fi

	@echo "🍪 Checking cookiecutter..."
	@if ! command -v cookiecutter &> /dev/null; then \
		echo "  Installing cookiecutter..."; \
		pipx install cookiecutter; \
	else \
		echo "  ✅ cookiecutter already installed"; \
	fi

	@echo "🔧 Checking PATH..."
	@if grep -q "dotfiles/scripts" ~/.bashrc; then \
		echo "  ✅ dotfiles/scripts already in PATH"; \
	else \
		echo 'export PATH="$$HOME/dotfiles/scripts:$$PATH"' >> ~/.bashrc; \
		echo "  ✅ Added dotfiles/scripts to PATH"; \
	fi

	@echo ""
	@echo "✅ Dotfiles setup complete!"
	@echo "👉 Run 'source ~/.bashrc' to reload your shell"