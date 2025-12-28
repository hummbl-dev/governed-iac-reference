#!/bin/bash
# trigger-copilot-agents-on-pr.sh
# Triggers multiple Copilot agent sessions for governed-iac-reference on PR events
# Usage: ./trigger-copilot-agents-on-pr.sh <pr-number> <repo> [owner]

set -euo pipefail

# Check dependencies
for cmd in gh jq; do
  if ! command -v "$cmd" &> /dev/null; then
    echo "Error: $cmd is required but not installed." >&2
    exit 1
  fi
done

# Check GitHub CLI authentication
if ! gh auth status &> /dev/null; then
  echo "Error: GitHub CLI is not authenticated. Run 'gh auth login' first." >&2
  exit 1
fi

PR_NUMBER="$1"
REPO="${2:-governed-iac-reference}"
OWNER="${3:-hummbl-dev}"

# Validate inputs
if [[ -z "$PR_NUMBER" ]]; then
  echo "Usage: $0 <pr-number> <repo> [owner]" >&2
  exit 1
fi

if !  [[ "$PR_NUMBER" =~ ^[0-9]+$ ]]; then
  echo "Error: PR number must be numeric" >&2
  exit 1
fi

# Define prompts/tasks for Copilot agents
AGENT_TASKS=(
  "Perform a Terraform security scan for this PR.  Summarize any issues."
  "Review this PR for compliance with organizational IaC policies."
  "Check documentation changes in this PR for completeness and clarity."
  "Analyze this PR for potential misconfigurations in cloud resources."
)

# Fetch PR context (branch, title)
echo "Fetching PR #$PR_NUMBER from $OWNER/$REPO..."
if !  PR_INFO=$(gh pr view "$PR_NUMBER" --repo "$OWNER/$REPO" --json headRefName,title,body); then
  echo "Error: Failed to fetch PR information" >&2
  exit 1
fi

BRANCH=$(echo "$PR_INFO" | jq -r '.headRefName // "unknown"')
TITLE=$(echo "$PR_INFO" | jq -r '.title // "No title"')
BODY=$(echo "$PR_INFO" | jq -r '.body // ""')

# Validate extracted data
if [[ "$BRANCH" == "unknown" ]]; then
  echo "Error: Could not extract branch name from PR" >&2
  exit 1
fi

echo "PR:  $TITLE (branch: $BRANCH)"
echo "Triggering ${#AGENT_TASKS[@]} agent tasks..."
echo ""

# Trigger Copilot agent sessions
FAILED_TASKS=0
for TASK_PROMPT in "${AGENT_TASKS[@]}"; do
  echo "Triggering:  $TASK_PROMPT"
  
  # Create full prompt with proper quoting
  FULL_PROMPT="$TASK_PROMPT

PR Title: $TITLE
PR Branch: $BRANCH
PR Body:  $BODY"
  
  if gh agent-task create --repo "$OWNER/$REPO" "$FULL_PROMPT"; then
    echo "✓ Success"
  else
    echo "✗ Failed" >&2
    ((FAILED_TASKS++))
  fi
  
  echo "---"
  sleep 1  # Brief delay to avoid rate limiting
done

echo ""
echo "Completed:  $((${#AGENT_TASKS[@]} - FAILED_TASKS))/${#AGENT_TASKS[@]} tasks succeeded"

if [[ $FAILED_TASKS -gt 0 ]]; then
  echo "Warning: $FAILED_TASKS task(s) failed" >&2
  exit 1
fi

echo "All Copilot agent sessions triggered successfully for PR #$PR_NUMBER."
