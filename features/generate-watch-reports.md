---
status: draft
owner: janus
priority: high
description: Generate watch reports summarizing anomalies, signals, and entity status
started: 2026-04-03
---

## Purpose

Janus needs to generate structured reports from watch logs that Juno can use for high-level visibility. Reports should summarize anomalies by severity, entity, and type; provide metrics on entity health (stall frequency, role drift incidents); and highlight escalations.

## Specification

**Input:** Watch logs from state/watchers/ directory

**Output:** Markdown and JSON reports in reports/ directory

**Behavior:**
- Aggregate watch log entries by entity and signal type
- Calculate metrics:
  - Entity stall frequency and duration
  - Unreviewed PR counts and age
  - Open issue backlogs
  - Trust bond modification frequency
  - Role drift incidents
- Group findings by severity:
  - **Critical:** Repo stalled >7 days, unacknowledged critical issue >48h
  - **High:** Role drift, unauthorized authors, missing pipeline stages
  - **Medium:** Stale issues, unreviewed PRs, occasional missed commits
- Generate report formats:
  - Markdown summary for human reading (reports/watch-summary-YYYY-MM-DD.md)
  - JSON detailed report (reports/watch-detailed-YYYY-MM-DD.json)
  - Entity scorecard (reports/entity-status-YYYY-MM-DD.json)

**Constraints:**
- Only report on signals that met filing threshold
- Do not assign actions (observation only)
- Timestamp all reports

## Interface

**Command:** `janus report watch` or `janus report watch --entity <name>`

**Arguments:**
- `--from <date>` (optional): report since date (default: last 7 days)
- `--entity <name>` (optional): focus on single entity
- `--format json|markdown|both` (optional): output format

**Output:** Markdown and/or JSON report files

## Dependencies

- Watch log directory (state/watchers/)
- Report output directory (reports/)
- Metrics calculation logic

## Testing

Acceptance criteria:
- [ ] Reads all watch log files
- [ ] Aggregates findings correctly by entity and type
- [ ] Calculates metrics accurately
- [ ] Generates readable markdown summary
- [ ] Generates valid JSON report
- [ ] Reports match underlying watch logs
- [ ] Date filtering works correctly

## Status Note

Planned. Design phase. Needs specification review with Juno before implementation.
