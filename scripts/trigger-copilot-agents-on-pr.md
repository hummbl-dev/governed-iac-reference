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

## Monitoring Agent Sessions

You can monitor Copilot agent sessions in several ways:

### 1. GitHub Web UI

- Go to your repository on GitHub.
- Click the **Agents** tab (or **Agent Sessions** in the PR view).
- View live logs, status, and results for each session.

### 2. GitHub CLI

Use the following commands to list and monitor sessions from your terminal:

```sh
# List all agent sessions for this repo
gh agent-task list --repo hummbl-dev/governed-iac-reference

# View logs for a specific session (replace <session-id> with the actual ID)
gh agent-task view <session-id> --repo hummbl-dev/governed-iac-reference --log --follow
```

### 3. Session Links

The script outputs direct URLs to each agent session. Open these links in your browser to view real-time progress and results.

## Customization

- Edit the `AGENT_TASKS` array in the script to add or change agent prompts.
