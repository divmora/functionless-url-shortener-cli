# Contributing to Functionless URL Shortener CLI

Thank you for your interest in contributing to **Functionless URL Shortener CLI**! We welcome bug reports, documentation improvements, feature suggestions, and code contributions.

Please review this guide before submitting issues or pull requests.

---

## Code of Conduct

This project adheres to the Contributor Covenant [Code of Conduct](https://github.com/divmora/.github/blob/main/CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

---

## Getting Started

### Prerequisites

- **Go 1.26+**
- **golangci-lint** v2
- **Make**

### Development Setup

```bash
git clone https://github.com/<your-username>/functionless-url-shortener-cli.git
cd functionless-url-shortener-cli
make test
```

---

## Development Workflow

- `make test` - Run unit tests
- `make lint` - Run golangci-lint
- `make build` - Build `./bin/shorten`
- `make clean` - Remove build output

---

## Conventional Commits

This project uses [Release Please](https://github.com/googleapis/release-please) to automate semantic versioning and release notes. All commit messages and Pull Request titles **must** adhere to the [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Format
```
<type>(<optional scope>): <description>
```

### Common Types
- `feat:` A new feature or endpoint (triggers minor version bump)
- `fix:` A bug fix or patch (triggers patch version bump)
- `docs:` Documentation-only changes
- `refactor:` Code or template refactoring without functional changes
- `test:` Adding or updating tests / validation
- `chore:` Tooling, CI/CD, dependency updates, or internal cleanup

---

## Submitting Pull Requests

1. Create a descriptive branch from `main`:
   ```bash
   git checkout -b feat/my-new-feature
   ```
2. Make your template or specification changes.
3. Validate templates locally:
   ```bash
   make validate
   ```
4. Commit your changes with a conventional commit message:
   ```bash
   git commit -m "feat(api): add custom header support"
   ```
5. Push to your fork and open a Pull Request against the `main` branch.
6. Ensure all CI checks pass. Maintainers will review your PR promptly.

---

## Licensing & Contributor Terms

By submitting a pull request, you agree that your contributions will be licensed under the project's [Apache License, Version 2.0](LICENSE).
