# Contributing

Thank you for your interest in contributing!

## Getting Started

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/your-feature`.
3. Follow the existing architecture and naming conventions.
4. Ensure your code compiles: `flutter build apk --debug`.
5. Run analysis: `flutter analyze`.
6. Run tests: `flutter test`.
7. Format code: `dart format .`.
8. Open a Pull Request against `develop`.

## Code Standards

- Follow Clean Architecture. Business logic must not appear in widgets.
- All async operations must have loading, success, error, and empty states.
- No hardcoded colors, fonts, spacing, or strings. Use the design system.
- New features must include unit tests.
- Use GetX for state management. Do not introduce other state managers.

## Commit Messages

Use conventional commits:

```
feat: add forgot password flow
fix: correct token refresh on 401
refactor: extract AuthTextField to shared widgets
test: add unit tests for validators
```
