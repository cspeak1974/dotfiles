#!/bin/bash

# Usage: new-python-project <project-name> [options]
# Templates: scripts (default), api, package, data, cli

TEMPLATE="scripts"
PROJECT_NAME=""
AUTHOR="$(git config user.name)"
RAW_EMAIL="$(git config user.email)"
if [[ "$RAW_EMAIL" == *"@users.noreply.github.com" ]]; then
  echo "ℹ️  GitHub noreply email detected. Project templates use your email in README and config files."
  read -p "Enter your real email address: " EMAIL
  EMAIL="${EMAIL:-your-email@example.com}"
else
  EMAIL="$RAW_EMAIL"
fi
PYTHON_VERSION="$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)"
DESCRIPTION="A short description of the project"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --template|-t)
      TEMPLATE="$2"
      shift 2
      ;;
    --author|-a)
      AUTHOR="$2"
      shift 2
      ;;
    --email|-e)
      EMAIL="$2"
      shift 2
      ;;
    --python|-p)
      PYTHON_VERSION="$2"
      shift 2
      ;;
    --description|-d)
      DESCRIPTION="$2"
      shift 2
      ;;
    --help|-h)
      echo "Usage: new-python-project <project-name> [options]"
      echo ""
      echo "Options:"
      echo "  --template,    -t  Template to use (default: scripts)"
      echo "  --author,      -a  Project author (default: git config user.name)"
      echo "  --email,       -e  Author email (default: git config user.email)"
      echo "  --python,      -p  Python version (default: current python3 version)"
      echo "  --description, -d  Project description"
      echo ""
      echo "Templates: scripts, api, package, data, cli"
      exit 0
      ;;
    *)
      PROJECT_NAME="$1"
      shift
      ;;
  esac
done

if [ -z "$PROJECT_NAME" ]; then
  echo "Error: project name is required"
  echo "Usage: new-python-project <project-name> [options]"
  exit 1
fi

TEMPLATE_DIR="$HOME/dotfiles/templates/$TEMPLATE"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "Error: template '$TEMPLATE' not found at $TEMPLATE_DIR"
  echo "Available templates: scripts, api, package, data, cli"
  exit 1
fi

cd ~/projects/source/repos
cookiecutter "$TEMPLATE_DIR" \
  --no-input \
  project_name="$PROJECT_NAME" \
  author="$AUTHOR" \
  email="$EMAIL" \
  python_version="$PYTHON_VERSION" \
  description="$DESCRIPTION"

echo ""
echo "⚙️  Running make install..."
cd "$HOME/projects/source/repos/$PROJECT_NAME"
make install

echo ""
echo "✅ Project '$PROJECT_NAME' created at ~/projects/source/repos/$PROJECT_NAME"
echo "👉 Next steps:"
echo "   cd ~/projects/source/repos/$PROJECT_NAME"
echo "   code ."