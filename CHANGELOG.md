# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0] - 2025-12-27

### Added

- Initial repository structure and governance scaffolding
- Branch protection rules and required status checks
- Security policy and reporting guidelines (SECURITY.md)
- Contribution guidelines (CONTRIBUTING.md)
- Issue templates: bug report, feature request, security
- Pull request template
- IaC security scan workflows (TFLint, Checkov, Trivy)
- CODEOWNERS and license
- Documentation: architecture, infra/README, policies/README stub

## [v0.2.0] - Upcoming

### Planned Enhancements

- Implement CI workflow for plan artifact storage and immutable apply
- Expand policies/ with OPA (Rego) and custom Checkov rules
- Add infrastructure examples in infra/modules/ and infra/envs/
- Document manual applies in CHANGELOG until automated workflow is live

### Known Gaps (v0.1.0)

- No automated apply workflow (manual only)
- Minimal policy enforcement (directory present, rules pending)
- infra/envs/ and infra/modules/ are skeletons
