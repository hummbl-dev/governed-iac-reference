# TODOs — Governed IaC Reference

## ✅ Completed

- Canonical repo structure scaffolded
- ARCHITECTURE.md authored and locked (v1.0)
- infra/README.md execution contract committed
- Branch protection and signed commits enforced
- IaC Security Scan workflow (TFLint, Checkov, Trivy) running on PRs and main
- Copilot automation and review process validated

---

## 🟡 Next Priorities

- [ ] policies/README.md — Document policy model and intent
- [ ] GOVERNANCE.md — Define authority, review, and exception processes
- [ ] CHANGELOG.md & VERSION — Formalize versioning and change tracking
- [ ] CI Enhancements
  - [ ] Add markdownlint/doc hygiene checks to CI
  - [ ] (Optional) Add OPA/Rego policy checks
- [ ] README.md — Continue filling out planned sections
- [ ] Documentation — Add usage and contribution guidelines if needed
- [ ] Branch Protection — Review and tune required status checks in GitHub

---

## Notes

- All changes must follow PR-first, review-first workflow.
- No direct commits to main.
- All commits must be GPG signed.
