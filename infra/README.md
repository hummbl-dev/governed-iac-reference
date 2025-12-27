# Infrastructure Execution Model (infra/)

This directory defines the **authoritative infrastructure surface** of the Governed Infrastructure-as-Code Reference System.

It does not exist to make infrastructure easy.
It exists to make infrastructure **intentional, reviewable, and governed**.

---

## 1. Scope of `infra/`

The `infra/` directory contains:

- Declarative infrastructure definitions
- Environment-specific configurations
- Module composition and wiring
- State backend configuration
- Execution boundaries consumed by CI

All contents of this directory are subject to the system’s core invariants and governance rules.

---

## 2. Explicit Non-Scope

The following are explicitly **out of scope** for `infra/` in v1.0:

- Application runtime configuration
- Deployment orchestration
- Local execution tooling
- Secrets materialization
- Cloud credential management
- Auto-remediation logic
- Ad-hoc experimentation

Any attempt to introduce these concerns violates the architectural contract.

---

## 3. Environment Model

Infrastructure is organized around **risk boundaries**, not convenience.

The system defines three environments:

- `dev`
- `staging`
- `prod`

Each environment represents a separate authority and blast-radius boundary.

Environment promotion is:

- Explicit
- Human-reviewed
- Version-controlled
- Logged via CI

There is no concept of implicit promotion or shared state between environments.

---

## 4. State and Backends

Terraform state is treated as a **governed artifact**, not an implementation detail.

Requirements:

- Each environment has an isolated state backend
- State backends are immutable in configuration once established
- State access is restricted to CI execution identities
- State is never accessed directly from developer workstations

State drift is detected and surfaced, not auto-corrected, in v1.0.

---

## 5. Execution Authority

Infrastructure execution authority resides **exclusively in CI**.

Specifically:

- `terraform apply` is never executed from a developer machine
- Local execution is limited to authoring, inspection, and planning (where permitted)
- All applies require:
  - Version control
  - Policy evaluation
  - Human approval
  - Recorded execution context

Terraform is an executor. It is not a control plane.

---

## 6. Failure Semantics

Failure is treated as a first-class signal.

In v1.0:

- Failed plans block execution
- Failed applies halt promotion
- Partial applies require human investigation
- No automated rollback is performed

The system prioritizes forensic clarity over rapid recovery.

---

## 7. Evolution Boundary

This document defines the v1.0 execution contract for infrastructure.

Changes to execution semantics require:

- A versioned architectural successor (v1.1+)
- Explicit invariant review
- Documented trade-offs

No silent evolution is permitted.

---

**End of infra execution contract.**
