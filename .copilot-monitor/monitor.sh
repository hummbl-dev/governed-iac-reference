#!/bin/bash
# Copilot Agent Monitor Script
# This script provides monitoring capabilities for parallel agent sessions

set -euo pipefail

MONITOR_DIR=".copilot-monitor"
STATUS_FILE="$MONITOR_DIR/monitor-status.md"

# Create monitor directory if it doesn't exist
mkdir -p "$MONITOR_DIR"

# Function to get current timestamp (portable across Unix systems)
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

# Function to log monitoring events
log_event() {
    local event="$1"
    local details="$2"
    local timestamp
    
    timestamp=$(get_timestamp)
    
    # Ensure status file exists
    if [ ! -f "$STATUS_FILE" ]; then
        return 1
    fi
    
    echo "| $timestamp | $event | $details |" >> "$STATUS_FILE"
}

# Function to check repository state
check_repo_state() {
    echo "=== Repository State Check ==="
    echo "Branch: $(git branch --show-current)"
    echo "Status: $(git status --porcelain | wc -l) modified files"
    echo "Last commit: $(git log -1 --oneline)"
    echo ""
}

# Function to monitor parallel agents
monitor_agents() {
    echo "=== Monitoring Parallel Agents ==="
    
    # Check for any other running processes or agent activities
    if pgrep -f "copilot" > /dev/null 2>&1; then
        echo "✓ Copilot processes detected"
    else
        echo "○ No other Copilot processes detected"
    fi
    
    # Check for recent file modifications
    local recent_changes=$(find . -type f -mmin -5 -not -path "./.git/*" 2>/dev/null | wc -l)
    echo "Recent file changes (last 5 min): $recent_changes"
    
    echo ""
}

# Main monitoring function
main() {
    local current_timestamp
    current_timestamp=$(get_timestamp)
    
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║     Copilot Agent Monitor - Parallel Session Test     ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    
    check_repo_state
    monitor_agents
    
    echo "=== Monitor Status ==="
    echo "Monitoring active at: $current_timestamp"
    echo "Status file: $STATUS_FILE"
    echo ""
    
    # Log this check
    if [ -f "$STATUS_FILE" ]; then
        log_event "Monitor Check" "Periodic monitoring check completed"
    fi
    
    echo "✓ Monitoring check complete"
}

# Execute main function
main
