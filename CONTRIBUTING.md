# Contributing to Foundry DS

Thank you for your interest in contributing to Foundry DS! We value your help in making this design system robust and production-grade.

## Getting Started

1.  **Fork the repository** on GitHub.
2.  **Clone your fork** locally:
    ```bash
    git clone https://github.com/lfbardi-don/foundry_ds.git
    ```
3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

## Development Workflow

1.  **Create a branch** for your feature or fix:
    ```bash
    git checkout -b feature/my-new-feature
    ```
2.  **Run the example app** to test your changes visually:
    ```bash
    cd example
    flutter run
    ```
3.  **Run tests** before committing:
    ```bash
    flutter test
    ```
4.  **Analyze code** to ensure no linting errors:
    ```bash
    flutter analyze
    ```

## Commit Guidelines

- Use clear and descriptive commit messages.
- Start with a verb (e.g., "Add", "Fix", "Update").
- Reference issues if applicable (e.g., "Fix #123").

## Design Principles

- **Semantic Naming**: Use `FColors.semantic` rather than raw colors.
- **Token Usage**: Always use `FSpacing`, `FRadius`, etc., instead of magic numbers.
- **Consistency**: Follow existing component patterns (e.g., `variant` enums).

## Submitting a Pull Request

1.  Push your branch to your fork.
2.  Open a Pull Request against the `main` branch.
3.  Provide a clear description of your changes and include screenshots if valid.

Thank you for contributing!
