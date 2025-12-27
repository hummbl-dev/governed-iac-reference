# How I Built a Governed Infrastructure System Without a CS Degree

## Problem

Cloud providers make it trivial to spin up resources, and just as trivial to misconfigure them. Misconfigurations routinely lead to data exposure, compliance findings, and noisy incident response.

Most teams use Infrastructure‑as‑Code (IaC), but governance is still handled with documents, tribal knowledge, and periodic audits instead of enforced mechanisms.

**Key issues I targeted:**

- Publicly exposed resources (e.g., internet‑accessible S3 buckets and security groups)
- Missing tags and metadata for cost, ownership, and compliance
- Over‑permissive IAM roles and policies
- Inconsistent application of encryption and network controls

## Model

The system is a governed IaC pipeline that treats policies as first‑class code and blocks non‑compliant changes before they ever reach production.

Core principles:

- **Policy‑as‑Code:** Express rules in Rego (via Open Policy Agent and Conftest) so they version, test, and review like any other code.
  - Open Policy Agent: <https://www.openpolicyagent.org/>
  - Conftest: <https://github.com/open-policy-agent/conftest>
- **Deny‑by‑default:** CI fails if policies are violated; there is no “best‑effort” mode.
- **Test harness:** Policies are covered by automated tests against representative IaC examples and Terraform plans.
- **Tight CI integration:** Every pull request runs policy checks and blocks merges when violations are detected.

In practice, the pipeline takes a Terraform plan, renders it to JSON, and evaluates it with Conftest so decisions are made on what will actually be deployed:

- Terraform plan JSON pattern:
  - Example: <https://dev.to/florianlenz/terraform-testing-with-open-policy-agent-and-conftest-secure-infrastructure-through-terraform-3fk4>
  - OPA + Terraform docs: <https://openpolicyagent.org/docs/terraform/>

## Execution

1. **Framework selection**

   - Chose **Open Policy Agent (OPA)** as the policy engine and **Conftest** as the CLI wrapper for testing Terraform and YAML‑style configs.
     - OPA: <https://www.openpolicyagent.org/>
     - Conftest: <https://github.com/open-policy-agent/conftest>
   - Standardized on GitHub Actions for CI so policy checks run on every PR and on main.
     - GitHub Actions docs: <https://docs.github.com/actions>

2. **Policy development**

   Authored an initial policy set in Rego:

   - No public S3 buckets or equivalent storage resources
   - Required resource tags (e.g., `owner`, `env`, `cost_center`)
   - IAM least privilege constraints on roles and policies
   - Network security groups restricted by CIDR, ports, and protocols
   - Encryption at rest required on storage and databases

3. **Test harness**

   - Created sample IaC and Terraform plan fixtures that represent “good” and “bad” configurations.
   - Wrote Conftest tests to assert:
     - Violations are caught with clear, human‑readable error messages
     - Known‑good templates pass cleanly to avoid noisy false positives

4. **CI pipeline**

   - Added a job to the GitHub Actions workflow that:
     - Runs `terraform plan`, converts the plan to JSON, and executes `conftest test` against it.
       - Terraform + OPA example:
         - <https://dev.to/florianlenz/terraform-testing-with-open-policy-agent-and-conftest-secure-infrastructure-through-terraform-3fk4>
         - <https://openpolicyagent.org/docs/terraform/>
     - Fails the build (and blocks merge) on any `deny` rule, surfacing violations directly in the PR UI.
   - Kept the implementation repo‑local so teams can extend or override policies as their context evolves.

## Results

- **Automated enforcement:** Misconfigurations like public S3 buckets, missing tags, and open security groups are stopped in CI instead of being discovered in production or audits.
- **Actionable feedback:** Developers see specific, policy‑backed error messages (e.g., which resource, which tag, which rule), making fixes fast and predictable.
- **Governed baseline:** New infrastructure changes now pass through a consistent, codified control layer rather than relying on ad‑hoc reviews, aligning with cloud governance and IaC security best practices.
  - AWS Well‑Architected Framework (security, reliability, and cost pillars):
    - <https://docs.aws.amazon.com/wellarchitected/latest/framework/>

## Limits

- **Scope:** Current coverage focuses on core policies (S3, tags, IAM, security groups, encryption) for a specific IaC tool and cloud provider; broader multi‑cloud and K8s support is still in progress.
- **Tooling gaps:** Certain edge cases and contextual exceptions still require manual review and judgement.
- **Adoption:** External validation and real‑world usage are in progress; the system is early but intentionally public for feedback and iteration.

## Next

- Expand policy coverage (cost controls, drift detection hooks, and environment‑specific guardrails) based on user feedback and real usage.
- Document adoption patterns: how to roll this in without blocking teams, how to handle exemptions, and how to evolve policies safely.
- Add first‑class support for more IaC frameworks and cloud providers, reusing the same policy‑as‑code backbone.

---

**Want to try it?**

Check out the repo and run it against your own infrastructure code:

- Governed IaC reference: <https://github.com/hummbl-dev/governed-iac-reference>

And tell me:

- Where the setup or docs are unclear
- Where policies are too strict, too weak, or hard to extend
- Where the CI feedback loop slows you down or feels noisy

---

This project is a proof that you can build a real, governed infrastructure system without a CS degree—what matters is a clear mental model, tight feedback loops, and a willingness to iterate in public.
