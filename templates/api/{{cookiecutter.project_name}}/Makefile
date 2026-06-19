.DEFAULT_GOAL := help

.PHONY: help install dev run test lint format clean

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Create .venv and install dependencies
	python3 -m venv .venv
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install -r requirements.txt

dev: ## Run development server with auto-reload
	.venv/bin/uvicorn api.main:app --reload --port 8000

run: ## Run production server
	.venv/bin/python -m api

test: ## Run tests
	.venv/bin/pytest tests/ -v

lint: ## Run ruff linter
	.venv/bin/ruff check .

format: ## Run ruff formatter
	.venv/bin/ruff format .

clean: ## Remove build artifacts and cache
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type d -name .pytest_cache -exec rm -rf {} +
	find . -type d -name .ruff_cache -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
