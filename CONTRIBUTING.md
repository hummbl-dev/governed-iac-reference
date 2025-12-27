# Contributing to Governed IaC Reference

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to this governed Infrastructure-as-Code reference repository.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for all contributors.

## How to Contribute

### Reporting Issues

- Search existing issues before creating a new one
- Use the issue templates when available
- Provide clear, detailed descriptions
- Include steps to reproduce for bugs

### Pull Request Process

1. **Fork and Clone**
   ```bash
   git clone https://github.com/your-username/governed-iac-reference.git
   cd governed-iac-reference
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feat/your-feature-name
   ```

3. **Make Your Changes**
   - Follow the coding standards
   - Run security scans locally
   - Update documentation as needed

4. **Commit with GPG Signing**
   ```bash
   git commit -S -m "type: description"
   ```

5. **Push and Create PR**
   ```bash
   git push origin feat/your-feature-name
   ```

### Commit Message Guidelines

Use conventional commits:

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `chore:` Maintenance tasks
- `refactor:` Code refactoring
- `test:` Test additions/changes
- `security:` Security improvements

### Code Quality Standards

- **Infrastructure Code**
  - Run `terraform fmt` before committing
  - Pass TFLint validation
  - Pass Checkov security scans
  - Pass Trivy vulnerability scans

- **Documentation**
  - Follow Markdown linting rules
  - Update README.md for user-facing changes
  - Update ARCHITECTURE.md for design changes

### Review Process

1. All PRs require at least one approval
2. All CI checks must pass
3. Code must be GPG signed
4. Branch must be up-to-date with main

## Development Setup

### Prerequisites

- Terraform >= 1.0
- TFLint
- Checkov
- Trivy
- GPG key configured

### Local Validation

Run security scans locally:

```bash
# TFLint
tflint --init
tflint

# Checkov
checkov -d .

# Trivy
trivy config .
```

### VS Code Integration

This repository includes VS Code settings and tasks for local validation.

## Questions?

Feel free to open an issue for questions or clarification.
