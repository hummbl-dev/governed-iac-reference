# Governed Infrastructure-as-Code Reference System

[![CI Status](https://github.com/hummbl-dev/governed-iac-reference/actions/workflows/iac-security-scan.yml/badge.svg)](https://github.com/hummbl-dev/governed-iac-reference/actions/workflows/iac-security-scan.yml)
[![Markdownlint](https://github.com/hummbl-dev/governed-iac-reference/actions/workflows/markdownlint.yml/badge.svg)](https://github.com/hummbl-dev/governed-iac-reference/actions/workflows/markdownlint.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Release](https://img.shields.io/github/v/release/hummbl-dev/governed-iac-reference)](https://github.com/hummbl-dev/governed-iac-reference/releases)

## What This Is

This repository is a reference implementation of a governed Infrastructure-as-Code (IaC) system.

It demonstrates how infrastructure changes can be made intentional, auditable, policy-constrained, and explicitly accountable to humans.

The system is designed around governance and failure containment rather than speed or local convenience, mirroring the constraints of real-world, regulated, or large-scale environments.

This is not a template for rapid experimentation; it is a model for disciplined infrastructure change.

## What This Is Not

This repository is **not**:

- A drop-in production platform
- A tutorial for learning Terraform or cloud basics
- A fast-feedback local development environment
- An opinionated “best practices” checklist
- A replacement for organizational governance or decision-making

## Why This Exists

Modern Infrastructure-as-Code systems fail less often due to tooling defects and more often due to
governance collapse: unclear authority, mutable standards, undocumented exceptions, and
non-reproducible decision paths. As systems scale, these failures become silent, systemic, and
expensive to reverse.

This repository exists to demonstrate a different approach: infrastructure that is constrained by
explicit design limits, governed by verifiable rules, and structured to remain legible under
organizational stress. The goal is not velocity. The goal is **durability under scrutiny**.

Specifically, this reference system exists to:

- Treat constraints (organizational, technical, and operational) as first-class design inputs
- Encode governance assumptions directly into architecture and workflow
- Favor auditability, determinism, and reversibility over convenience
- Remain usable in environments where common tooling assumptions (e.g., local Docker) do not hold

## Core Principles

## Design Constraints (At a Glance)

This system is intentionally constrained. These constraints are not limitations to be removed;
they are invariants the architecture is designed to hold.

- **No local Docker dependency**  
  All workflows must execute without requiring a local Docker daemon.
- **Deterministic environments**  
  Dev, staging, and prod are structurally identical; differences are data, not topology.
- **Plan-before-apply enforcement**  
  All infrastructure changes require a reviewed, recorded plan prior to application.
- **Policy-as-code required**  
  Security, compliance, and guardrails are enforced via automated policy checks.
- **CI is the control plane**  
  Human interaction is mediated through version control and CI gates, not imperative access.
- **Reversibility over speed**  
  Every change must be designed to be safely rolled back.
- **Explicit non-goals documented**  
  Anything out of scope is named and intentionally excluded.

## Repository Structure (Guided Tour)

This repository is organized to reflect how governed infrastructure is actually operated.

```text
repo-root/
├── .github/
│   └── workflows/        # CI gates: linting, planning, policy checks, controlled apply
├── infra/
│   ├── modules/          # Reusable Terraform modules (no environment coupling)
│   └── envs/             # Environment wiring: dev / staging / prod
├── policies/             # Policy-as-code (OPA / Checkov)
├── scripts/              # Promotion, verification, and safety tooling
├── docs/                 # Deep dives and supporting architecture material
├── ARCHITECTURE.md       # Canonical system architecture (authoritative)
└── README.md             # Entry point and narrative overview
```

Each directory exists to enforce separation of concerns between **definition**, **validation**, and **execution**.

## How to Use This Repository

This repository is designed to be **studied**, not deployed directly. It exists to demonstrate patterns, not to run production workloads.

**To explore this repository:**

1. **Read `ARCHITECTURE.md` first** – This document explains the canonical system design and trade-offs.
2. **Review `.github/workflows/`** – See how governance is enforced via CI gates.
3. **Examine `policies/`** – Understand how policy-as-code validates infrastructure changes.
4. **Study `infra/modules/`** – See how reusable Terraform modules are structured without environment coupling.
5. **Follow the repository evolution** – Use Git history to understand the progression from initial setup to full governance.

## Versioning

This repository follows [Semantic Versioning](https://semver.org/) (`MAJOR.MINOR.PATCH`):

- **MAJOR**: Breaking changes to governance model, workflow structure, or architectural invariants
- **MINOR**: New governance features, additional policy checks, or non-breaking workflow improvements
- **PATCH**: Documentation fixes, CI tuning, or clarifications

See the [CHANGELOG.md](CHANGELOG.md) for a complete version history.

## Audience

This repository is intended for:

- **Platform engineers** building governed infrastructure systems
- **DevOps architects** designing compliance-first CI/CD workflows
- **Security teams** enforcing policy-as-code in cloud environments
- **Engineering leaders** evaluating governance models for regulated industries
- **Infrastructure auditors** reviewing controlled change management practices

This is **not** for teams seeking:

- Rapid prototyping environments
- Local development with Docker Compose
- Quick-start Terraform tutorials
- Opinionated "best practices" checklists
