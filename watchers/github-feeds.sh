#!/bin/bash

# Janus GitHub Atom Feed Watcher
# Monitors .atom feeds for all entity repos and flags anomalies

set -euo pipefail

REPOS=(
  "koad/juno"
  "koad/vulcan"
  "koad/veritas"
  "koad/mercury"
  "koad/muse"
  "koad/sibyl"
  "koad/argus"
  "koad/salus"
  "koad/janus"
  "koad/aegis"
  "koad/vesta"
  "koad/iris"
  "koad/koad-io"
)

STATE_DIR="$HOME/.janus/state"
REPORT_FILE="$HOME/.janus/reports/activity-$(date +%Y%m%d).md"

# Initialize report
mkdir -p "$(dirname "$REPORT_FILE")"
{
  echo "# Janus Watch Report — $(date '+%Y-%m-%d %H:%M:%S')"
  echo ""
  echo "**Repos checked:** ${#REPOS[@]}"
  echo ""
} > "$REPORT_FILE"

# Track anomalies
anomalies=""
new_activity=""

for repo in "${REPOS[@]}"; do
  feed_url="https://github.com/$repo/commits/main.atom"
  state_file="$STATE_DIR/$(echo "$repo" | tr '/' '-').xml"

  echo "▶ Checking $repo..." >&2

  # Fetch current feed
  if ! current=$(curl -s "$feed_url" 2>/dev/null); then
    anomalies+="⚠ $repo: Feed fetch failed\n"
    continue
  fi

  # Check if state file exists
  if [[ ! -f "$state_file" ]]; then
    # First run - store state and note baseline
    echo "$current" > "$state_file"
    new_activity+="✓ $repo: Baseline established\n"
    continue
  fi

  # Compare feeds (simple: look for new entry IDs)
  previous=$(cat "$state_file")

  # Extract first entry timestamp from current feed
  current_timestamp=$(echo "$current" | grep -oP '<updated>\K[^<]+' | head -1)

  # Extract first entry timestamp from previous feed
  previous_timestamp=$(echo "$previous" | grep -oP '<updated>\K[^<]+' | head -1)

  if [[ "$current_timestamp" != "$previous_timestamp" ]]; then
    new_activity+="✓ $repo: New commit detected\n"
    # Store updated state
    echo "$current" > "$state_file"
  else
    # Check how stale the last commit is
    if [[ -n "$current_timestamp" ]]; then
      # Parse the timestamp
      last_commit_date=$(echo "$current_timestamp" | cut -d'T' -f1)
      today=$(date +%Y-%m-%d)

      # Calculate days difference (simple approximation)
      days_old=$(( ($(date -d "$today" +%s) - $(date -d "$last_commit_date" +%s)) / 86400 ))

      if (( days_old > 7 )); then
        anomalies+="⚠ $repo: No commits in $days_old days (last: $last_commit_date)\n"
      fi
    fi
  fi
done

# Write findings to report
{
  echo "## Activity Summary"
  echo ""
  if [[ -n "$new_activity" ]]; then
    echo "### New Activity Detected"
    echo ""
    printf "$new_activity"
    echo ""
  fi

  if [[ -n "$anomalies" ]]; then
    echo "### Anomalies Flagged"
    echo ""
    printf "$anomalies"
    echo ""
  else
    echo "No anomalies detected."
    echo ""
  fi

  echo "---"
  echo ""
  echo "*Watch completed by Janus — $(date '+%Y-%m-%d %H:%M:%S')*"
} >> "$REPORT_FILE"

echo "✓ Watch report written to $REPORT_FILE" >&2
cat "$REPORT_FILE"
