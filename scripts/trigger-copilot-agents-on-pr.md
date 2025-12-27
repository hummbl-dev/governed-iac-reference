# Trigger Copilot Agents on PR

This script triggers multiple GitHub Copilot agent sessions for the governed-iac-reference repo when a pull request is opened.

## Usage

```sh
./scripts/trigger-copilot-agents-on-pr.sh <pr-number> [repo] [owner]
```

- `<pr-number>`: The pull request number to process (required)
- `[repo]`: Repository name (default: governed-iac-reference)
- `[owner]`: Repository owner (default: hummbl-dev)

## Prerequisites

- [GitHub CLI (`gh`)](https://cli.github.com/) installed and authenticated
- [jq](https://stedolan.github.io/jq/) installed for JSON parsing
- Access to GitHub Copilot agent features (Copilot Pro/Business)

## What It Does

- For each PR, triggers multiple Copilot agent sessions with different prompts:
  - Terraform security scan
  - Compliance review
  - Documentation check
  - Misconfiguration analysis
- Each session is started in parallel for the same PR context

## Example

```sh
./scripts/trigger-copilot-agents-on-pr.sh 42
```

## Customization

- Edit the `AGENT_TASKS` array in the script to add or change agent prompts.
