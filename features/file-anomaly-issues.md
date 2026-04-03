---
status: complete
owner: janus
priority: critical
description: File GitHub issues on entity repos for detected anomalies
completed: 2026-04-03
---

## Purpose

When Janus detects an anomaly (stalled entity, role drift, pipeline break, trust chain gap, or authorization concern), it files a GitHub Issue on the relevant entity's repo to escalate and make the problem visible to Juno and the entity.

## Specification

**Input:** Anomaly type, entity/area affected, evidence (commit hashes, date ranges, issue references)

**Output:** GitHub Issue URL, issue number

**Behavior:**
- Determine target repo (entity repo or koad/juno for escalation)
- Format title as: `[janus] <signal-type>: <entity-or-area>`
- Include detailed description with:
  - What was detected (the signal)
  - When it was detected (date, feed entry)
  - Evidence (commits, issues, dates)
  - Why it exceeds threshold (7+ day stall, recent trust change, etc.)
  - Cross-references (to other issues, to Juno if escalation needed)
- Use consistent labels: `blocked`, `stalled`, `pipeline`, `trust`, `role-drift`, etc.
- Do not assign or mark as urgent—let Juno route to responsible entity

**Edge cases:**
- Duplicate issue already exists → update with latest evidence
- False positive (normal cadence, draft work) → do not file
- Requires Juno escalation → include cross-ref to koad/juno

## Implementation

Implemented via `gh` CLI. Authentication via koad's GitHub token. Issue templates stored in `protocols/`. Duplicate detection uses fuzzy search on open issues.

## Dependencies

- `gh` CLI (GitHub command-line tool)
- koad authentication (for issue creation on entity repos)
- Watch logs (to gather evidence)
- Anomaly detection logic (VESTA-SPEC-013 signals)

## Testing

Tested against live entity repos. Successfully files issues with proper formatting, cross-references, and labels.

## Status Note

Production-ready. Read-only access model respected.
