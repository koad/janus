---
status: draft
owner: janus
priority: critical
description: Execute complete watch cycle (fetch feeds, detect anomalies, file issues)
started: 2026-04-03
---

## Purpose

Janus needs a command that orchestrates a complete watch cycle: fetch all entity atom feeds, detect anomalies, and file GitHub issues for signals that exceed threshold. This is the main entry point for Janus operations.

## Specification

**Input:** (None) Operates on configured entity list and watch thresholds

**Output:** Watch log summary, list of issues filed, anomalies detected

**Behavior:**
- Fetch latest atom feed for each monitored entity repo
- Parse commits, issues, PRs for anomalies:
  - Stalled repos (>7 days with open work)
  - Commit author mismatches (unexpected authors)
  - Unacknowledged critical issues (>48h)
  - Modified trust bonds (without issue trail)
  - Missing pipeline stages (incomplete sequences)
  - Role drift (entity outside declared scope)
- For each anomaly that exceeds threshold:
  - Check if duplicate issue already exists
  - File new GitHub Issue with proper format
  - Log to watch log
- Generate cycle summary report
- Update watch state (last-scanned times, ETags)

**Constraints:**
- Read-only access (no fixing, only reporting)
- Alert, don't assign (let Juno route)
- Calibrate for false positives (only real anomalies)

## Interface

**Command:** `janus watch cycle` or `janus watch --all`

**Arguments:**
- `--entity <name>` (optional): watch single entity instead of all
- `--verbose` (optional): detailed output

**Output:** JSON summary with anomalies found and issues filed

## Dependencies

- GitHub feeds (all entity repos)
- `gh` CLI for issue creation
- Watch log schema
- Anomaly threshold configuration

## Testing

Acceptance criteria:
- [ ] Detects 7+ day stall on test entity
- [ ] Detects unauthorized commit author
- [ ] Detects unacknowledged critical issue >48h
- [ ] Detects modified trust bond
- [ ] Files issues with correct formatting and labels
- [ ] Does not file duplicate issues
- [ ] Updates watch log with all findings
- [ ] Runs without manual intervention

## Status Note

In design phase. Needs integration with feed fetcher, anomaly detection engine, and issue filer. Currently implemented as ad-hoc scripts; needs to be unified into single command.
