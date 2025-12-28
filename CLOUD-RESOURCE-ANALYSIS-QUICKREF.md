# Quick Reference: IaC Security Workflow Issues

> **TL;DR**: The workflow is good but needs 3 critical fixes before production use.

---

## 🔴 Must Fix Before Merge (50 minutes)

### 1. Add Job Permissions (5 min)

Add to each job:

```yaml
permissions:
  contents: read
  security-events: write  # Only for SARIF upload jobs
```

### 2. Pin Actions to SHA (15 min)

Change from:

```yaml
uses: actions/checkout@v6
```

To:

```yaml
# actions/checkout@v6.0.0
uses: actions/checkout@1e31de5234b9f8995739874a8ce0492dc87873e2
```

### 3. Save Scan Results (30 min)

Add to each scanner job:

```yaml
- name: Upload results
  if: always()
  uses: actions/upload-artifact@v4
  with:
    name: scan-results
    path: results.json
    retention-days: 90
```

---

## 🟡 Should Fix This Sprint (32 minutes)

### 4. Initialize TFLint (2 min)

Add before `tflint --recursive`:

```yaml
- name: Initialize TFLint
  run: tflint --init
```

### 5. Add Caching (10 min)

Add to TFLint job:

```yaml
- uses: actions/cache@v4
  with:
    path: ~/.tflint.d/plugins
    key: tflint-${{ hashFiles('.tflint.hcl') }}
```

### 6. Add Summary Job (20 min)

See `CLOUD-RESOURCE-ANALYSIS-IMPROVED.yml` for example.

---

## 🟢 Optional Enhancements

- SARIF upload to Security tab
- PR comment notifications
- Workflow documentation

---

## Copy-Paste Solution

Use the complete improved workflow:

```bash
cp CLOUD-RESOURCE-ANALYSIS-IMPROVED.yml .github/workflows/iac-security-scan.yml
```

Test in feature branch before merging.

---

## Why This Matters

| Issue | Risk If Not Fixed |
|-------|-------------------|
| No job permissions | Privilege escalation vulnerability |
| Unpinned actions | Supply chain attack vector |
| No artifacts | Fails compliance audits (SOC 2, ISO 27001) |
| No TFLint init | Misses cloud-specific security checks |
| No caching | Slower builds, higher costs |

---

## Checklist

**Before Merge**:
- [ ] Job permissions added
- [ ] Actions pinned to SHA
- [ ] Artifacts uploaded
- [ ] Tested in feature branch

**This Sprint**:
- [ ] TFLint initialization
- [ ] Caching implemented
- [ ] Summary job added

**Optional**:
- [ ] SARIF integration
- [ ] PR notifications

---

## Get Help

- **Full analysis**: `CLOUD-RESOURCE-ANALYSIS.md`
- **Executive summary**: `CLOUD-RESOURCE-ANALYSIS-EXECUTIVE-SUMMARY.md`
- **Improved workflow**: `CLOUD-RESOURCE-ANALYSIS-IMPROVED.yml`

---

**Last Updated**: 2025-12-28
