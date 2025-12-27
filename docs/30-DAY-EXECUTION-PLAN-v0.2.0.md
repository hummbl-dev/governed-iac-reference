# 30-Day Execution Plan: v0.2.0 Policy-as-Code & Narrative

## Overview

A focused, actionable plan to deliver v0.2.0 value and public signal, based on validated priorities and risk flags from SITREP/AAR and external review.

---

## Agreement Points

1. **Policy-as-Code is the Right Axis**
   - Build on governance framework with real, enforceable policies.
   - Deliver 5-7 deny-by-default policies, test harness, CI integration, and clear failure messages.
2. **Single Narrative Artifact**
   - Publish one canonical Dev.to article (Problem → Model → Execution → Results → Limits → Next).
   - All other platforms link to this source.
3. **External Validation is Critical**
   - Support 2 external users, document friction in `docs/FAILURE_MODES.md`.
4. **30-Day Plan is Realistic**
   - Week-by-week breakdown, no handwaving.

---

## Risk Flags & Framing

- State background once as methodology, not credential defense.
- Keep language operational, not motivational.
- Defer all non-policy work until after external validation.

---

## Week-by-Week Breakdown

### **Week 1: Narrative + Scope Lock**

- [ ] **Day 1-2:** Draft Dev.to article (structure: Problem/Model/Execution/Results/Limits/Next)
- [ ] **Day 3:** Publish article (imperfect is fine)
- [ ] **Day 4-5:** Update v0.2.0 milestone to focus only on policy work
- [ ] **Day 6-7:** Remove any v0.2.0 scope items not related to policies

**Deliverable:** Published article + locked v0.2.0 scope

### **Week 2: Policy Foundation**

- [ ] **Day 8-9:** Implement policy #1: No public S3 buckets
- [ ] **Day 10-11:** Implement policy #2: Require resource tags
- [ ] **Day 12-13:** Implement policy #3: IAM least privilege
- [ ] **Day 14:** Write test harness for policies 1-3

**Deliverable:** 3 working policies with tests

### **Week 3: Complete Policy Suite**

- [ ] **Day 15-16:** Implement policy #4: Network security groups
- [ ] **Day 17-18:** Implement policy #5: Encryption at rest
- [ ] **Day 19-20:** CI integration (policies block merges)
- [ ] **Day 21:** Failure message clarity pass

**Deliverable:** 5 policies enforced in CI

### **Week 4: External Validation**

- [ ] **Day 22:** r/devops post: "Try this governed IaC system"
- [ ] **Day 23-25:** Support 2 external users
- [ ] **Day 26-27:** Document friction in `docs/FAILURE_MODES.md`
- [ ] **Day 28-30:** Write `docs/ADOPTION_STRATEGY.md`

**Deliverable:** 2 external users + friction documentation

---

## The One Action (If Nothing Else)

**Write and publish the Dev.to article this week.**

- Converts private work → public signal
- Attracts the 2 external users you need
- Clarifies your own thinking (writing forces precision)
- Creates shareable proof before job applications

**Title:**
> How I Built a Governed Infrastructure System Without a CS Degree

**Length:** 1500-2000 words
**Tone:** Operational, not inspirational
**Structure:** Problem/Model/Execution/Results/Limits/Next

---

## Final Directive

- Technical axis: Policy-as-Code depth (v0.2.0)
- Narrative artifact: One Dev.to article
- Validation loop: 2 external users → friction docs
- Everything else is deferred or deleted.
- Execute the 30-day plan. No additions. No substitutions.
