# Security Policy

This document outlines the security policy for the Governed Infrastructure-as-Code Reference repository.

## Supported Versions

This is a reference implementation repository. Security updates are applied to the main branch.

| Branch | Supported          |
| ------ | ------------------ |
| main   | :white_check_mark: |
| other  | :x:                |

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, report security vulnerabilities by:

1. **GitHub Security Advisories** (Recommended)
   - Navigate to the Security tab
   - Click "Report a vulnerability"
   - Fill out the advisory form

2. **Direct Contact**
   - Email: <reuben@hummbl.io>
   - Subject: "[SECURITY] Governed IaC Reference Vulnerability"

### What to Include

Please include as much of the following information as possible:

- Type of vulnerability
- Affected components
- Steps to reproduce
- Potential impact
- Suggested remediation
- Your contact information

### Response Timeline

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 5 business days
- **Status Update**: Weekly until resolved
- **Resolution**: Depends on severity

### Severity Levels

- **Critical**: Immediate risk, patch within 24-48 hours
- **High**: Significant risk, patch within 7 days
- **Medium**: Moderate risk, patch within 30 days
- **Low**: Minimal risk, addressed in next release

## Security Features

This repository implements multiple security controls:

### Automated Scanning

- **TFLint**: Terraform linting and validation
- **Checkov**: IaC security and compliance scanning
- **Trivy**: Vulnerability scanning for configs and containers
- **Markdownlint**: Documentation quality checks

### Branch Protection

- Required pull request reviews
- Required status checks
- GPG signed commits
- No direct pushes to main

### Dependency Management

- Dependabot configured for GitHub Actions
- Automated security updates
- Regular dependency audits

## Security Best Practices

When contributing:

- Never commit secrets or credentials
- Use GPG-signed commits
- Run local security scans before pushing
- Follow principle of least privilege
- Document security-related changes

## Scope

This security policy covers:

- Repository code and configuration
- GitHub Actions workflows
- Documentation
- Infrastructure-as-Code templates

Out of scope:

- Third-party dependencies (report to their maintainers)
- General GitHub platform issues

## Contact

For security-related questions or concerns:

- Security issues: <reuben@hummbl.io>
- General questions: Open a discussion in GitHub Discussions

Thank you for helping keep this repository secure!
