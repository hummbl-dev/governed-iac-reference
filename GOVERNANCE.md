# GOVERNANCE.md

## Governance Model

This document defines the governance, review, and exception processes for the Governed Infrastructure-as-Code Reference System.

---

### 1. Authority & Roles

- **Maintainers:** Responsible for approving changes, enforcing policy, and managing releases.
- **Contributors:** Anyone proposing changes via pull requests (PRs).
- **Reviewers:** Designated maintainers or trusted contributors with review authority.

---

### 2. Change Management

- All changes must be proposed via PRs—no direct commits to `main`.
- All PRs require at least one approval from a maintainer.
- All commits must be GPG signed.
- PRs must pass all required status checks (CI, security, policy, lint).
- Code owner review is required for protected areas (e.g., infra/, policies/).

---

### 3. Exception Process

- Exceptions to policy or process must be proposed in writing (in PR description or as a tracked issue).
- All exceptions require explicit approval from at least two maintainers.
- All exceptions must be documented in `/policies/` or `/GOVERNANCE.md` with justification and scope.

---

### 4. Audit & Transparency

- All governance decisions, exceptions, and reviews must be recorded in PRs or tracked issues.
- The CHANGELOG.md must be updated for all significant changes.
- Versioning must be maintained in the VERSION file.

---

### 5. Review Cadence

- Regular review of policies, CI, and governance processes (at least quarterly).
- Emergency reviews may be called by any maintainer in response to incidents or critical findings.

---

## Notes

- This governance model is subject to change via PR and review.
- All stakeholders are encouraged to propose improvements.
