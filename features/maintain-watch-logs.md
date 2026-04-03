---
status: complete
owner: janus
priority: high
description: Maintain structured watch logs and state for all monitored repos
completed: 2026-04-03
---

## Purpose

Janus maintains watch logs to track what was scanned, when, and what anomalies were found. These logs provide the audit trail for all signals and enable detection of patterns (e.g., recurring stalls, repeated role drift in same entity).

## Specification

**Input:** Scan results, anomalies detected, issues filed

**Output:** Timestamped log entries in `state/` and `reports/`

**Behavior:**
- Create watch log entry for each scan cycle (daily or per-interval)
- Log format: One JSON entry per entity per scan with:
  - Timestamp (ISO 8601)
  - Entity name
  - Feed URL and last-updated timestamp
  - Commit count and cadence (commits/day)
  - Issue activity (open, closed, stale)
  - PR activity (open, reviewed, stale)
  - Any anomalies detected (type, severity, evidence)
  - Issues filed (issue numbers, titles)
- Maintain `state/` for current watch state (last-scanned times, cached feed ETags)
- Generate `reports/` summaries at end of active period

**Edge cases:**
- Incomplete scan (some feeds failed) → mark as partial, note which failed
- Duplicate anomaly detected → increment counter, don't duplicate log entry
- First-time scan of new entity → initialize baseline metrics

## Implementation

Log files in `state/watchers/` (ephemeral, excluded from git). Summary reports in `reports/` (committed). Uses JSON format for machine parsing by Argus.

## Dependencies

- State directory (state/watchers/)
- Reports directory (reports/)
- Watch log schema (documented in protocols/)

## Testing

Logs are validated for completeness and JSON well-formedness. Reports are readable and match event counts from actual scans.

## Status Note

Production-ready. State logs are ephemeral (cache); reports are persistent (tracked in git).
