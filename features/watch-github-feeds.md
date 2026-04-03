---
status: complete
owner: janus
priority: critical
description: Monitor GitHub atom feeds for all entity repos and detect anomalies
completed: 2026-04-03
---

## Purpose

Janus monitors the GitHub `.atom` feeds for all 13 entity repos (koad/juno, koad/vulcan, koad/veritas, koad/mercury, koad/muse, koad/sibyl, koad/argus, koad/salus, koad/janus, koad/aegis, koad/vesta, koad/iris, and koad/koad-io) to detect signals: stalled entities, role drift, silent blockers, pipeline breaks, and trust chain gaps. This is the core scanning capability.

## Specification

**Input:** Entity repository list, scan interval (daily during active periods)

**Output:** Structured watch log entries, anomaly flags

**Behavior:**
- Fetch atom feed for each entity repo
- Parse commit patterns (authors, messages, timestamps, cadence)
- Parse issue activity (stale issues, unassigned work, unacknowledged escalations)
- Parse PR activity (unreviewed, conflicting, unauthorized changes)
- Detect trust bond changes (new bonds, revocations, scope modifications)
- Identify pipeline stalls (Mercury publishing, Veritas review backlog, Argus gates)
- Detect role drift (entities working outside declared scope)
- Flag anomalies that cross the signal threshold

**Edge cases:**
- Repo temporarily unavailable → flag, retry next cycle
- Feed parsing error → emit diagnostic, skip entry
- Weekend/expected downtime → do not flag as stall
- Draft/in-progress work with recent commits → not a stall

## Implementation

Implemented in `watchers/` directory. Uses GitClaw for always-on GitHub event watching on fourty4. Includes feed parsers, pattern matchers, and anomaly threshold logic.

## Dependencies

- GitClaw (always-on GitHub event watching)
- Entity atom feeds (public, available via GitHub)
- koad authentication (for access to private entity repos)
- Watch log persistence (state/watchers/)

## Testing

Tested against real entity repos. Detects stalls >7 days with open work, unauthorized authors, unacknowledged critical issues >48 hours, modified trust bonds, and missing pipeline stages.

## Status Note

Production-ready. Runs on fourty4 (Mac Mini).
