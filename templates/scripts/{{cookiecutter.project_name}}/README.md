# {{cookiecutter.project_name}}

{{cookiecutter.description}}

## Setup

The project is created with `.venv` already initialized and dependencies installed.

If you need to reinstall:

```bash
make install
```

Then reopen your terminal to activate the virtual environment.

## Usage

```bash
make run
```

## Development

```bash
make test    # run tests
make lint    # run ruff linter
make format  # run ruff formatter
make clean   # remove build artifacts
```

## Author

{{cookiecutter.author}} <{{cookiecutter.email}}>