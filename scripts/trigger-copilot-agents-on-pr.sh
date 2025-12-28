#!/bin/bash
# trigger-copilot-agents-on-pr.sh
# Triggers multiple Copilot agent sessions for governed-iac-reference on PR events
# Usage: ./trigger-copilot-agents-on-pr.sh <pr-number> <repo> [owner]

set -e

PR_NUMBER="$1"
REPO="${2:-governed-iac-reference}"
OWNER="${3:-hummbl-dev}"

if [[ -z "$PR_NUMBER" ]]; then
  echo "Usage: $0 <pr-number> <repo> [owner]"
  exit 1
fi

# Define prompts/tasks for Copilot agents
AGENT_TASKS=(
  "Perform a Terraform security scan for this PR. Summarize any issues."
  "Review this PR for compliance with organizational IaC policies."
  "Check documentation changes in this PR for completeness and clarity."
  "Analyze this PR for potential misconfigurations in cloud resources."
)

# Fetch PR context (branch, title)
PR_INFO=$(gh pr view "$PR_NUMBER" --repo "$OWNER/$REPO" --json headRefName,title,body)
BRANCH=$(echo "$PR_INFO" | jq -r '.headRefName')
TITLE=$(echo "$PR_INFO" | jq -r '.title')
BODY=$(echo "$PR_INFO" | jq -r '.body')

# Trigger Copilot agent sessions

for TASK_PROMPT in "${AGENT_TASKS[@]}"; do
  echo "Triggering Copilot agent: $TASK_PROMPT"
  gh agent-task create \
    --repo "$OWNER/$REPO" \
    "$TASK_PROMPT\n\nPR Title: $TITLE\nPR Branch: $BRANCH\nPR Body: $BODY"
  echo "---"
done

echo "All Copilot agent sessions triggered for PR #$PR_NUMBER."
