# AI Agent Instructions: Governed IaC Reference System

## System Philosophy & Context

This is **not** a production system or rapid prototyping environment. It's a reference implementation demonstrating governed, auditable Infrastructure-as-Code. Every design choice prioritizes **auditability over convenience** and **human accountability over automation speed**.

**Key principle:** *No infrastructure change occurs without explicit human accountability, even when automation would be faster.*

**Current Version:** v0.1.0 (see [VERSION](../VERSION))
**Status:** Reference implementation — study, don't deploy directly
**Branch Context:** Check current branch against `main` to understand work-in-progress features

## Core Invariants (Never Violate)

1. **No local Docker** — All execution must work without local Docker daemon
2. **No local `terraform apply`** — Applies only happen via CI workflows
3. **CI is the control plane** — Terraform is an executor, not a controller
4. **Policy before execution** — Invalid states are prevented, not repaired
5. **Explicit human accountability** — All meaningful infrastructure changes require human approval

## Repository Structure

```
.github/workflows/     # CI gates: ALL applies must pass security scans first
  ├── iac-security-scan.yml    # TFLint, Checkov, Trivy (runs on PR + push to main)
  └── markdownlint.yml         # Documentation quality gate
infra/
  └── envs/           # Isolated environments (dev/staging/prod) - CURRENTLY EMPTY
                      # No shared state, no production resources yet (v0.1.0)
policies/             # Policy-as-code (minimal in v0.1.0, roadmap for v0.2.0+)
  └── README.md       # Documents gap: OPA/Rego policies planned for v0.2.0
scripts/              # Promotion, verification, and safety tooling (currently empty)
                      # Planned: environment promotion, drift detection, policy test harness
GOVERNANCE.md         # Authority, review, exception processes (TO BE CREATED)
docs/                 # Deep architecture context and decision records
  ├── APPLY_WORKFLOW.md          # How applies work (currently manual)
  ├── 30-DAY-EXECUTION-PLAN-v0.2.0.md  # Development roadmap
  ├── FAILURE_MODES.md           # External validation findings (v0.2.0)
  └── AAR-*.md / SITREP-*.md     # After-action reviews and status reports
```

## Critical Workflows

### Security Scanning (REQUIRED for all PRs)
All PRs must pass these scans before merge:
- **TFLint**: Terraform linting and best practices
- **Checkov**: Security misconfiguration detection (currently built-in rules only)
- **Trivy**: IaC vulnerability scanning
- **Markdownlint**: Documentation hygiene

Run locally via VS Code tasks (Cmd+Shift+P → "Tasks: Run Task"):
```bash
# Individual scans
security:tflint
security:checkov
security:trivy
lint:markdown

# Or all security scans at once
security:all
```

**Note:** There is no `task` command or Taskfile/Makefile. Use VS Code tasks from `.vscode/tasks.json`.

### Apply Workflow (v0.1.0 - Manual Only)
- **No automated applies exist yet** — This is intentional for v0.1.0
- CI runs validation only (lint, security, policy checks)
- Manual applies must be documented in [CHANGELOG.md](../CHANGELOG.md)
- v0.2.0 will add: plan artifact storage → human approval → automated apply
- See [docs/APPLY_WORKFLOW.md](../docs/APPLY_WORKFLOW.md) for roadmap

### Commit Conventions
Use conventional commits with GPG signing:
- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation only
- `security:` Security improvements
- `chore:` Maintenance

## Terraform Patterns

- **No `terraform apply` from local machines** — ever. Use CI workflows.
- **Environments are isolated** — dev/staging/prod have separate state backends, no shared state
- **State is a governed artifact** — never accessed directly from developer workstations
- **Modules live in `infra/modules/`** (when present) with no environment coupling
- **Environment-specific config in `infra/envs/{dev,staging,prod}/`** (currently empty scaffolds)

## Current State (v0.1.0)

- **Infrastructure:** infra/envs/ directories are empty — this is intentional scaffolding
- **Policies:** policies/ has minimal enforcement; built-in Checkov rules only
- **Apply workflow:** Manual only; automated plan→approve→apply coming in v0.2.0
- **Target audience:** Senior platform engineers, not beginners
- **Primary deliverable:** Governance model demonstration, not running infrastructure

## v0.2.0 Roadmap (Policy-as-Code Focus)

The next version adds real, enforceable policy-as-code:

**Core Policies (5-7 deny-by-default rules):**
- No public S3 buckets
- Required resource tags (owner, environment, project)
- IAM least privilege enforcement
- Network security group restrictions
- Encryption at rest requirements

**Implementation:**
- OPA/Rego or custom Checkov policies in `policies/`
- Policy test harness with CI integration
- Clear failure messages explaining violations
- Policies block merges (not advisory warnings)

**Scripts:**
- `scripts/promote-env.sh` — Safe environment promotion workflow
- `scripts/test-policies.sh` — Local policy validation
- `scripts/detect-drift.sh` — State drift detection helper

**Documentation:**
- GOVERNANCE.md — Authority model, review process, policy exceptions
- docs/FAILURE_MODES.md — External validation findings
- docs/ADOPTION_STRATEGY.md — Onboarding guidance

**Validation:** 2 external users testing the system, friction documented

## When Suggesting Changes

### DO:
- Maintain separation between definition (modules), validation (policies), and execution (CI)
- Document all design decisions with rationale
- Update [ARCHITECTURE.md](../ARCHITECTURE.md) for structural changes
- Update [CHANGELOG.md](../CHANGELOG.md) with version-appropriate entries
- Run security scans before suggesting PR merge
- Reference the constraint model when proposing features

### DO NOT:
- Suggest local Docker usage
- Propose local `terraform apply` workflows
- Add auto-remediation of production drift
- Remove or weaken governance gates
- Optimize for speed at the expense of auditability
- Add convenience features that bypass human review

## Key Documentation

Read these FIRST before suggesting major changes:
- [ARCHITECTURE.md](../ARCHITECTURE.md) — Canonical system design, invariants, and philosophy
- [README.md](../README.md) — User-facing overview and constraints
- [CONTRIBUTING.md](../CONTRIBUTING.md) — Contribution standards and PR process
- [infra/README.md](../infra/README.md) — Infrastructure execution model
- [SECURITY.md](../SECURITY.md) — Security vulnerability reporting
- [docs/30-DAY-EXECUTION-PLAN-v0.2.0.md](../docs/30-DAY-EXECUTION-PLAN-v0.2.0.md) — Development roadmap

**Missing but planned:**
- GOVERNANCE.md — Should define authority boundaries, review process, and policy exception handling
- docs/FAILURE_MODES.md — Will document friction points from external validation (v0.2.0)
- docs/ADOPTION_STRATEGY.md — Will provide onboarding guidance (v0.2.0)

## Common Misconceptions

❌ "This is slow, let's add local Docker for faster feedback"
✅ This constraint is intentional — it forces governance-first thinking

❌ "Let's auto-apply terraform changes to save time"
✅ Human accountability is non-negotiable; automation executes, doesn't justify

❌ "We should make this easier for beginners"
✅ Target audience is senior platform engineers; complexity reflects real-world governance

## Version Semantics

- **MAJOR**: Breaking changes to governance model or architectural invariants
- **MINOR**: New governance features, additional policy checks
- **PATCH**: Documentation fixes, CI tuning, clarifications

## When Asked to Add Features

Check against explicit non-goals in [ARCHITECTURE.md](../ARCHITECTURE.md#9-explicit-non-goals-v10):
- Local Docker usage
- Auto-remediate drift
- Application runtime management
- Cost optimization features
- Organizational process replacement

If requested feature conflicts with non-goals, explain the architectural rationale rather than implementing.

**v0.2.0 Priority Features:**
Focus on policy-as-code only. Defer everything else until external validation is complete:
- ✅ Implement 5-7 deny-by-default policies
- ✅ Build policy test harness
- ✅ Integrate policies into CI (blocking)
- ❌ Defer: Automated apply workflows
- ❌ Defer: Infrastructure examples (until policies proven)
- ❌ Defer: Additional documentation (until FAILURE_MODES.md exists)

## Example Interactions

**User**: "Add a workflow to apply terraform automatically"
**Response**: Explain that CI-gated applies with human approval are a core invariant (§4.2, §5.2). Suggest improving the approval workflow instead.

**User**: "Make the README more beginner-friendly"
**Response**: Note that target audience is senior practitioners (§11). Suggest improving conceptual clarity while maintaining appropriate technical depth.

**User**: "Add Docker Compose for local testing"
**Response**: Reference §5.1 (No Local Docker constraint). Explain how this mirrors real-world enterprise constraints and strengthens the governance model.
