# Apply Workflow Strategy

## Purpose

Clarifies how infrastructure changes are applied in the governed IaC reference system, ensuring artifact immutability and human accountability.

## Current State (v0.1.0)

- **Validation Only:** CI/CD runs lint, security, and policy checks on PRs.
- **No Automated Apply:** No workflow currently applies Terraform changes post-merge.
- **Manual Apply:** If applies are needed, they must be performed manually and documented in the CHANGELOG.
- **Artifact Immutability:** Not yet implemented; future versions will store and reuse plan artifacts.

## Intended Future State (v0.2.0+)

- **Plan → Store → Approve → Apply:**
  1. PR triggers `terraform plan` in CI; plan artifact is stored.
  2. Manual approval required (CODEOWNERS or designated reviewers).
  3. On merge, CI runs `terraform apply` using the stored plan artifact.
  4. All actions are logged and auditable.

## Roadmap

- Implement plan artifact storage in CI (GitHub Actions Artifacts).
- Create apply workflow that consumes stored plan post-approval.
- Document all manual applies in CHANGELOG until automated workflow is live.

## References

- See [ARCHITECTURE.md](../ARCHITECTURE.md#15-cicd-pipeline-detail) for pipeline details.
- See [CHANGELOG.md](../CHANGELOG.md) for manual apply records.
