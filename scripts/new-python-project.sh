#!/bin/bash

# Usage: new-python-project <project-name>

if [ -z "$1" ] || [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: new-python-project <project-name>"
  echo "Creates a new Python project in ~/projects/source/repos/<project-name>"
  exit 0
fi

PROJECT_NAME=$1
PROJECT_DIR="$HOME/projects/source/repos/$PROJECT_NAME"
TEMPLATE_DIR="$HOME/dotfiles/templates/python-project"

# Create project directory
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Copy template files
cp -r "$TEMPLATE_DIR/." .

# Initialize git
git init

# Create virtual environment
python3 -m venv .venv

echo "✅ Project '$PROJECT_NAME' created at $PROJECT_DIR"
echo "👉 Next steps:"
echo "   cd $PROJECT_DIR"
echo "   code ."