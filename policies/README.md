# Policy Roadmap

## Purpose

Outlines the current and future state of policy enforcement in the governed IaC reference system.

## Current State (v0.1.0)

- **Minimal Enforcement:** Directory exists, but no OPA/Checkov policies are implemented yet.
- **Conceptual Model:** Policy intent and model are described in [ARCHITECTURE.md](../ARCHITECTURE.md#9-explicit-non-goals-v10).
- **Checkov Integration:** Security scan runs in CI, but coverage is limited to built-in rules.

## Roadmap (v0.2.0+)

- Populate this directory with:
  - OPA (Rego) policies for environment, resource, and change constraints
  - Custom Checkov policies for organization-specific requirements
  - Policy coverage matrix mapping controls to risks
- Document policy enforcement and exceptions in [CHANGELOG.md](../CHANGELOG.md).

## Status

This gap is intentional for v0.1.0. Policy coverage will expand in future releases.
